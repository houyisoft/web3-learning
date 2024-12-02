// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title RCCStake
 * @dev 这个合约用于管理RCC代币的质押和奖励分配。
 * 它允许用户质押特定的代币以获得RCC奖励，并在一定时期后解除质押。
 * 合约所有者可以添加新的质押池，并设置每个池的权重和参数。
 */
contract RCCStake is Ownable {
    /**
     * @dev Pool结构体定义了质押池的相关信息。
     * 包括质押代币地址、质押池权重、最后奖励计算区块、
     * 每个质押代币累计的RCC奖励、池中的总质押代币数量、
     * 最小质押金额以及解除质押的锁定区块数。
     */
    struct Pool {
        address stTokenAddress; // 质押代币地址
        uint256 poolWeight; // 质押池权重
        uint256 lastRewardBlock; // 最后奖励计算区块
        uint256 accRCCPerST; // 每个质押代币累计的RCC奖励
        uint256 stTokenAmount; // 池中的总质押代币数量
        uint256 minDepositAmount; // 最小质押金额
        uint256 unstakeLockedBlocks; // 解除质押的锁定区块数
    }

    /**
     * @dev User结构体定义了用户质押的相关信息。
     * 包括用户质押的代币数量、已领取的RCC奖励、
     * 待领取的RCC奖励以及解质押请求列表。
     */
    struct User {
        uint256 stAmount; // 用户质押的代币数量
        uint256 finishedRCC; // 已领取的RCC奖励
        uint256 pendingRCC; // 待领取的RCC奖励
        UnstakeRequest[] requests; // 解质押请求
    }

    /**
     * @dev UnstakeRequest结构体定义了解质押请求的信息。
     * 包括解质押的数量和解锁的区块号。
     */
    struct UnstakeRequest {
        uint256 amount; // 解质押数量
        uint256 unlockBlock; // 解锁的区块号
    }

    /**
     * @dev rewardToken是RCC奖励代币的接口。
     * totalAllocPoint是所有质押池的总权重。
     * rewardPerBlock是每个区块的奖励RCC数量。
     */
    IERC20 public rewardToken; // RCC奖励代币
    uint256 public totalAllocPoint; // 总权重
    uint256 public rewardPerBlock; // 每个区块的奖励RCC数量

    /**
     * @dev pools是质押池的数组。
     * userInfo是映射，用于存储每个用户在每个质押池中的质押信息。
     */
    Pool[] public pools;
    mapping(uint256 => mapping(address => User)) public userInfo;

    /**
     * @dev PoolAdded事件在添加新的质押池时触发。
     * Staked事件在用户质押代币时触发。
     * Unstaked事件在用户解除质押时触发。
     * RewardClaimed事件在用户领取RCC奖励时触发。
     */
    event PoolAdded(uint256 pid, address stTokenAddress, uint256 poolWeight, uint256 minDepositAmount);
    event Staked(address indexed user, uint256 pid, uint256 amount);
    event Unstaked(address indexed user, uint256 pid, uint256 amount);
    event RewardClaimed(address indexed user, uint256 pid, uint256 amount);

    /**
     * @dev 构造函数用于初始化RCC奖励代币和每个区块的奖励数量。
     * @param _rewardToken RCC奖励代币的地址。
     * @param _rewardPerBlock 每个区块的奖励RCC数量。
     * @param initialOwner 合约所有者的地址。
     */
    constructor(IERC20 _rewardToken, uint256 _rewardPerBlock, address initialOwner) Ownable(initialOwner) {
        rewardToken = _rewardToken;
        rewardPerBlock = _rewardPerBlock;
    }

    /**
     * @dev addPool函数用于添加新的质押池。
     * 只有合约所有者可以调用此函数。
     * @param _stTokenAddress 质押代币的地址。
     * @param _poolWeight 质押池的权重。
     * @param _minDepositAmount 最小质押金额。
     * @param _unstakeLockedBlocks 解除质押的锁定区块数。
     */
    function addPool(
        address _stTokenAddress,
        uint256 _poolWeight,
        uint256 _minDepositAmount,
        uint256 _unstakeLockedBlocks
    ) external onlyOwner {
        pools.push(
            Pool({
                stTokenAddress: _stTokenAddress,
                poolWeight: _poolWeight,
                lastRewardBlock: block.number,
                accRCCPerST: 0,
                stTokenAmount: 0,
                minDepositAmount: _mi