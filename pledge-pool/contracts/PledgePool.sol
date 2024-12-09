// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 引入 OpenZeppelin 的 IERC20 接口，用于支持 ERC20 代币操作
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title PledgePool - 一个支持多资产流动性池和贷款功能的智能合约
contract PledgePool {
    // **数据结构定义**

    /// @dev 贷款结构，保存单个贷款的详细信息
    struct Loan {
        address borrower; // 借款人地址
        address collateralToken; // 抵押物的 ERC20 代币地址
        uint256 collateralAmount; // 抵押物数量
        uint256 loanAmount; // 借款金额
        uint256 interestRate; // 年化利率（以千分比表示）
        uint256 dueDate; // 贷款到期时间（时间戳）
        bool isRepaid; // 贷款是否已偿还
    }

    /// @dev 流动性池结构，保存特定资产池的信息
    struct Pool {
        address assetToken; // 流动性池中使用的 ERC20 代币地址
        uint256 totalLiquidity; // 流动性池的总资产量
        uint256 interestRate; // 流动性池的固定利率（千分比）
    }

    // **状态变量**

    mapping(uint256 => Loan) public loans; // 贷款池，按贷款 ID 存储贷款详情
    uint256 public loanIdCounter; // 贷款 ID 计数器，用于生成唯一贷款 ID

    mapping(address => Pool) public liquidityPools; // 流动性池，按资产地址存储池信息
    mapping(address => mapping(address => uint256)) public userBalances; // 用户余额，按用户地址和资产地址存储
    mapping(address => uint256) public poolLiquidity; // 每种资产流动性池的总流动性

    uint256 public platformFeeRate; // 平台费用率（千分比）
    address public owner; // 合约所有者地址，用于管理平台

    // **事件定义**

    event Deposit(address indexed user, address token, uint256 amount); // 记录存款事件
    event Withdraw(address indexed user, address token, uint256 amount); // 记录提款事件
    event LoanCreated(
        uint256 loanId,
        address indexed borrower,
        uint256 loanAmount,
        address collateralToken,
        uint256 collateralAmount
    ); // 记录贷款创建事件
    event LoanRepaid(uint256 loanId, address indexed borrower); // 记录贷款偿还事件
    event CollateralSeized(uint256 loanId, address indexed lender); // 记录抵押物清算事件

    // **修饰符**
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // **构造函数**

    /// @dev 初始化合约，设置平台费率和所有者
    /// @param _platformFeeRate 平台费用率（千分比）
    constructor(uint256 _platformFeeRate) {
        owner = msg.sender; // 设置合约部署者为所有者
        platformFeeRate = _platformFeeRate; // 设置平台费用率
    }

    // **核心功能**

    /// @dev 用户存款到流动性池
    /// @param token 存入的 ERC20 代币地址
    /// @param amount 存入的代币数量
    function deposit(address token, uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");

        // 从用户转移代币到合约
        IERC20(token).transferFrom(msg.sender, address(this), amount);

        // 更新用户余额和流动性池总量
        userBalances[msg.sender][token] += amount;
        poolLiquidity[token] += amount;

        emit Deposit(msg.sender, token, amount);
    }

    /// @dev 用户从流动性池提款
    /// @param token 提取的 ERC20 代币地址
    /// @param amount 提取的代币数量
    function withdraw(address token, uint256 amount) external {
        require(userBalances[msg.sender][token] >= amount, "Insufficient balance");

        // 更新用户余额和流动性池总量
        userBalances[msg.sender][token] -= amount;
        poolLiquidity[token] -= amount;

        // 转移代币到用户
        IERC20(token).transfer(msg.sender, amount);

        emit Withdraw(msg.sender, token, amount);
    }

    /// @dev 创建贷款
    /// @param loanAmount 贷款金额
    /// @param collateralToken 抵押物的 ERC20 代币地址
    /// @param collateralAmount 抵押物数量
    /// @param interestRate 贷款的年化利率（千分比）
    /// @param dueDate 贷款到期时间（时间戳）
    function createLoan(
        uint256 loanAmount,
        address collateralToken,
        uint256 collateralAmount,
        uint256 interestRate,
        uint256 dueDate
    ) external {
        require(collateralAmount > 0, "Collateral must be greater than zero");
        require(dueDate > block.timestamp, "Due date must be in the future");

        // 将抵押物转移到合约
        IERC20(collateralToken).transferFrom(msg.sender, address(this), collateralAmount);

        // 创建新贷款并存储到贷款池
        loanIdCounter++;
        loans[loanIdCounter] = Loan({
            borrower: msg.sender,
            collateralToken: collateralToken,
            collateralAmount: collateralAmount,
            loanAmount: loanAmount,
            interestRate: interestRate,
            dueDate: dueDate,
            isRepaid: false
        });

        emit LoanCreated(loanIdCounter, msg.sender, loanAmount, collateralToken, collateralAmount);
    }

    /// @dev 偿还贷款
    /// @param loanId 贷款 ID
    /// @param loanToken 贷款的 ERC20 代币地址
    function repayLoan(uint256 loanId, address loanToken) external {
        Loan storage loan = loans[loanId];
        require(loan.borrower == msg.sender, "Only borrower can repay the loan");
        require(!loan.isRepaid, "Loan already repaid");
        require(block.timestamp <= loan.dueDate, "Loan due date has passed");

        // 计算还款金额
        uint256 repaymentAmount = loan.loanAmount + (loan.loanAmount * loan.interestRate) / 10000;

        // 从借款人转移还款金额到合约
        IERC20(loanToken).transferFrom(msg.sender, address(this), repaymentAmount);

        // 标记贷款已偿还并返还抵押物
        loan.isRepaid = true;
        IERC20(loan.collateralToken).transfer(loan.borrower, loan.collateralAmount);

        emit LoanRepaid(loanId, msg.sender);
    }

    /// @dev 清算过期贷款
    /// @param loanId 贷款 ID
    function seizeCollateral(uint256 loanId) external onlyOwner {
        Loan storage loan = loans[loanId];
        require(!loan.isRepaid, "Loan already repaid");
        require(block.timestamp > loan.dueDate, "Loan is not overdue");

        // 将抵押物转移到平台所有者
        IERC20(loan.collateralToken).transfer(owner, loan.collateralAmount);
        loan.collateralAmount = 0;

        emit CollateralSeized(loanId, loan.borrower);
    }

    // **管理功能**

    /// @dev 设置平台费用率
    /// @param _platformFeeRate 新的平台费用率
    function setPlatformFeeRate(uint256 _platformFeeRate) external onlyOwner {
        platformFeeRate = _platformFeeRate;
    }
}