const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("RCCStake Contract", function () {
    let rewardToken, rccStake, deployer, user1, user2;

    before(async function () {
        [deployer, user1, user2] = await ethers.getSigners();

        // 部署 RewardToken 合约
        const RewardToken = await ethers.getContractFactory("RewardToken");
        rewardToken = await RewardToken.deploy(ethers.parseEther("1000000")); // 初始供应量 1,000,000
        await rewardToken.waitForDeployment();

        // 部署 RCCStake 合约
        const RCCStake = await ethers.getContractFactory("RCCStake");
        rccStake = await RCCStake.deploy(
            rewardToken.target, // 奖励代币地址
            ethers.parseEther("1"), // 每区块奖励 1 RCC
            deployer.address // 初始所有者
        );
        await rccStake.waitForDeployment();

        // 转移奖励代币到 RCCStake
        await rewardToken.transfer(rccStake.target, ethers.parseEther("500000"));
    });

    it("Should add a native staking pool", async function () {
        await rccStake.addPool(
            ethers.ZeroAddress, // 原生币
            100, // 权重
            ethers.parseEther("0.01"), // 最小质押金额
            100 // 解锁区块数
        );
        const pool = await rccStake.pools(0);
        expect(pool.stTokenAddress).to.equal(ethers.ZeroAddress);
    });

    it("Should add an ERC20 staking pool", async function () {
        await rccStake.addPool(
            rewardToken.target, // 使用 ERC20 代币
            200, // 权重
            ethers.parseEther("10"), // 最小质押金额
            200 // 解锁区块数
        );
        const pool = await rccStake.pools(1);
        expect(pool.stTokenAddress).to.equal(rewardToken.target);
    });

    it("Should allow staking native tokens", async function () {
        const stakeAmount = ethers.parseEther("0.05");
        await rccStake.connect(user1).stake(0, stakeAmount, { value: stakeAmount }); // 原生币质押
        const userInfo = await rccStake.userInfo(0, user1.address);
        expect(userInfo.stAmount).to.equal(stakeAmount);
    });

    it("Should allow staking ERC20 tokens", async function () {
        const stakeAmount = ethers.parseEther("15");

        // 转移代币并授权
        await rewardToken.transfer(user2.address, ethers.parseEther("100"));
        await rewardToken.connect(user2).approve(rccStake.target, stakeAmount);

        // 质押
        await rccStake.connect(user2).stake(1, stakeAmount);

        const userInfo = await rccStake.userInfo(1, user2.address);
        expect(userInfo.stAmount).to.equal(stakeAmount);
    });
});