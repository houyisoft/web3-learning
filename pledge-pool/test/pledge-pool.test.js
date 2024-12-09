const { expect } = require("chai");

describe("PledgePool", function () {
    let PledgePool, pledgePool, owner, user1, user2, token, MockToken;

    before(async function () {
        // 部署 Mock ERC20 代币
        const MockERC20 = await ethers.getContractFactory("MockERC20");
        token = await MockERC20.deploy("MockToken", "MTK", ethers.parseUnits("1000000", 18)); // 初始供应 100 万代币
        await token.waitForDeployment();

        // 部署 PledgePool 合约
        PledgePool = await ethers.getContractFactory("PledgePool");
        pledgePool = await PledgePool.deploy(100); // 平台费率设置为 1%
        await pledgePool.waitForDeployment();

        // 获取测试账户
        [owner, user1, user2] = await ethers.getSigners();

        // 分发代币给测试用户
        await token.transfer(user1.address, ethers.parseUnits("1000", 18)); // 给 user1 分配 1000 代币
        await token.transfer(user2.address, ethers.parseUnits("1000", 18)); // 给 user2 分配 1000 代币
    });

    describe("Deployment", function () {
        it("Should deploy the contract correctly", async function () {
            expect(await pledgePool.platformFeeRate()).to.equal(100); // 检查平台费率
            expect(await pledgePool.owner()).to.equal(owner.address); // 检查所有者
        });
    });

    describe("Deposit and Withdraw", function () {
        it("Should allow users to deposit tokens", async function () {
            // 用户存款
            await token.connect(user1).approve(pledgePool.target, ethers.parseUnits("100", 18));
            await pledgePool.connect(user1).deposit(token.target, ethers.parseUnits("100", 18));

            // 检查存款余额
            const balance = await pledgePool.userBalances(user1.address, token.target);
            expect(balance).to.equal(ethers.parseUnits("100", 18));
        });

        it("Should allow users to withdraw tokens", async function () {
            // 用户提款
            await pledgePool.connect(user1).withdraw(token.target, ethers.parseUnits("50", 18));

            // 检查提款后余额
            const balance = await pledgePool.userBalances(user1.address, token.target);
            expect(balance).to.equal(ethers.parseUnits("50", 18));
        });
    });

    describe("Loan Creation", function () {
        it("Should allow users to create a loan", async function () {
            // 获取当前区块时间戳
            const currentBlock = await ethers.provider.getBlock("latest");
            const futureTimestamp = currentBlock.timestamp + 7 * 24 * 60 * 60; // 7天后

            await token.connect(user1).approve(pledgePool.target, ethers.parseUnits("200", 18));
            await pledgePool.connect(user1).createLoan(
                ethers.parseUnits("100", 18), // 贷款金额
                token.target, // 抵押物代币地址
                ethers.parseUnits("200", 18), // 抵押物数量
                500, // 利率 5%
                futureTimestamp // 到期时间
            );

            const loan = await pledgePool.loans(1);
            expect(loan.dueDate).to.be.above(currentBlock.timestamp); // 确保到期时间有效
        });
    });

    describe("Loan Repayment", function () {
        it("Should allow users to repay loans", async function () {
            // 用户偿还贷款（本金+利息）
            const repaymentAmount = ethers.parseUnits("105", 18); // 本金+利息
            await token.connect(user1).approve(pledgePool.target, repaymentAmount);

            await pledgePool.connect(user1).repayLoan(1, token.target);

            const loan = await pledgePool.loans(1);
            expect(loan.isRepaid).to.be.true; // 确保贷款状态为已偿还
        });
    });

    describe("Loan Liquidation", function () {
        it("Should allow the owner to seize collateral for overdue loans", async function () {
            // 获取当前区块时间
            const currentBlock = await ethers.provider.getBlock("latest");
            const currentTimestamp = currentBlock.timestamp;

            // 模拟贷款创建时间
            const loanTimestamp = currentTimestamp + 1; // 确保创建时有效
            await ethers.provider.send("evm_setNextBlockTimestamp", [loanTimestamp]);
            await ethers.provider.send("evm_mine");

            // 授权 PledgePool 合约代币使用权限
            await token.connect(user2).approve(pledgePool.target, ethers.parseUnits("300", 18));

            // 创建贷款
            await pledgePool.connect(user2).createLoan(
                ethers.parseUnits("150", 18), // 贷款金额
                token.target, // 抵押物代币地址
                ethers.parseUnits("300", 18), // 抵押物数量
                500, // 利率 5%
                loanTimestamp + 7 * 24 * 60 * 60 // 设置未来到期时间
            );

            // 推进时间到贷款过期
            const overdueTimestamp = loanTimestamp + 8 * 24 * 60 * 60; // 8天后
            await ethers.provider.send("evm_setNextBlockTimestamp", [overdueTimestamp]);
            await ethers.provider.send("evm_mine");

            // 检查贷款状态
            const loanBefore = await pledgePool.loans(1);
            expect(loanBefore.isRepaid).to.be.false; // 确保贷款未偿还

            // 调用清算方法
            await pledgePool.connect(owner).seizeCollateral(1);

            // 再次检查贷款状态
            const loanAfter = await pledgePool.loans(1);
            expect(loanAfter.collateralAmount).to.equal(0); // 确保抵押物已清算
            expect(loanAfter.isRepaid).to.be.false; // 确保未被标记为已偿还
        });
    });
});