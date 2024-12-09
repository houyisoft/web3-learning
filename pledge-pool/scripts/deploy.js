const hre = require("hardhat");

async function main() {
    const ethers = hre.ethers;

    // 部署初始化参数
    const platformFeeRate = 100; // 平台费用率 1%

    // 获取部署账户
    const [deployer] = await ethers.getSigners();

    // 获取部署账户的余额
    const balance = await ethers.provider.getBalance(deployer.address);
    console.log(`Deployer Address: ${deployer.address}`);
    console.log(`Deployer Balance: ${ethers.formatEther(balance)} ETH`);

    // 估算 Gas 成本
    const estimatedGasLimit = BigInt(5000000); // 使用 BigInt 表示 Gas 上限
    const estimatedGasPrice = ethers.parseUnits("10", "gwei"); // Gas 单价
    const estimatedDeploymentCost = estimatedGasLimit * estimatedGasPrice; // BigInt 运算

    console.log(`Estimated Deployment Cost: ${ethers.formatEther(estimatedDeploymentCost)} ETH`);

    if (balance < estimatedDeploymentCost) {
        console.error("Error: Insufficient funds to deploy the contract.");
        return;
    }

    console.log("Deploying PledgePool contract...");

    // 获取合约工厂
    const PledgePool = await ethers.getContractFactory("PledgePool");

    // 部署合约
    const pledgePool = await PledgePool.deploy(platformFeeRate, {
        gasLimit: estimatedGasLimit, // BigInt 直接使用
        gasPrice: estimatedGasPrice, // BigNumber 保持一致
    });

    // 等待部署完成
    await pledgePool.waitForDeployment();

    console.log("PledgePool deployed to:", pledgePool.target);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });