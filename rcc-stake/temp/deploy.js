const { ethers } = require("hardhat");

async function main() {
    // 1. 部署 ERC20 奖励代币
    console.log("Deploying reward token (ERC20)...");
    const RewardToken = await ethers.getContractFactory("RewardToken"); // 替换为你的 ERC20 合约名称
    const initialSupply = ethers.parseEther("1000000"); // 初始化供应量为 1,000,000
    const rewardToken = await RewardToken.deploy(initialSupply);
    await rewardToken.waitForDeployment(); // 等待部署完成
    console.log("Reward Token deployed to:", rewardToken.target);

    // 2. 部署 RCCStake 合约
    console.log("Deploying RCCStake contract...");
    const [deployer] = await ethers.getSigners(); // 获取部署者账户
    const RCCStake = await ethers.getContractFactory("RCCStake");
    const rewardPerBlock = ethers.parseEther("1"); // 每区块奖励 1 RCC
    const rccStake = await RCCStake.deploy(
        rewardToken.target,
        rewardPerBlock,
        deployer.address
    );
    await rccStake.waitForDeployment();
    console.log("RCCStake deployed to:", rccStake.target);

    // 3. 添加质押池（原生币和 ERC20 代币）
    console.log("Adding staking pools...");
    const addNativePoolTx = await rccStake.addPool(
        ethers.ZeroAddress, // 原生币
        100, // 权重
        ethers.parseEther("0.01"), // 最小质押金额
        100 // 解锁区块数
    );
    await addNativePoolTx.wait();
    console.log("Added native currency staking pool");

    const addERC20PoolTx = await rccStake.addPool(
        rewardToken.target, // ERC20 代币
        200, // 权重
        ethers.parseEther("10"), // 最小质押金额
        200 // 解锁区块数
    );
    await addERC20PoolTx.wait();
    console.log("Added ERC20 token staking pool");

    // 4. 分配奖励代币
    console.log("Transferring reward tokens to RCCStake...");
    const rewardAmount = ethers.parseEther("500000"); // 奖励总量 500,000 RCC
    const transferTx = await rewardToken.transfer(rccStake.target, rewardAmount);
    await transferTx.wait();
    console.log("Transferred reward tokens to RCCStake");

    console.log("Deployment complete.");
    console.log("Reward Token address:", rewardToken.target);
    console.log("RCCStake contract address:", rccStake.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});