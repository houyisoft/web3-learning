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
    struct Pool {
        address stTokenAddress; // 质押代币地址，address(0) 表示原生币
        uint256 poolWeight; // 质押池权重
        uint256 lastRewardBlock; // 最后奖励计算区块
        uint256 accRCCPerST; // 每个质押代币累计的 RCC 奖励
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
        uint256 finishedRCC; // 已领取的 RCC 奖励
        uint256 pendingRCC; // 待领取的 RCC 奖励
        UnstakeRequest[] requests; // 解质押请求
    }

    struct UnstakeRequest {
        uint256 amount; // 解质押数量
        uint256 unlockBlock; // 解锁的区块号
    }

    IERC20 public rewardToken; // RCC 奖励代币
    uint256 public totalAllocPoint; // 总权重
    uint256 public rewardPerBlock; // 每个区块的奖励 RCC 数量

    /**
   * @dev pools是质押池的数组。
     * userInfo是映射，用于存储每个用户在每个质押池中的质押信息。
     **/
    Pool[] public pools;
    mapping(uint256 => mapping(address => User)) public userInfo;

    /**
    * @dev PoolAdded事件在添加新的质押池时触发。
     * Staked事件在用户质押代币时触发。
     * Unstaked事件在用户解除质押时触发。
     * RewardClaimed事件在用户领取RCC奖励时触发。
     */
    //质押池的唯一标识符（Pool ID）,质押池中允许的质押代币的地址,质押池的权重,最小质押金额
    event PoolAdded(uint256 pid, address stTokenAddress, uint256 poolWeight, uint256 minDepositAmount);
    //用户地址,质押池的唯一标识符（Pool ID）,质押数量
    event Staked(address indexed user, uint256 pid, uint256 amount);
    //用户地址,质押池的唯一标识符（Pool ID）,解除质押数量
    event Unstaked(address indexed user, uint256 pid, uint256 amount);
    //用户地址,质押池的唯一标识符（Pool ID）,领取的RCC奖励数量
    event RewardClaimed(address indexed user, uint256 pid, uint256 amount);

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
                minDepositAmount: _minDepositAmount,
                unstakeLockedBlocks: _unstakeLockedBlocks
            })
        );
        totalAllocPoint += _poolWeight;
        emit PoolAdded(pools.length - 1, _stTokenAddress, _poolWeight, _minDepositAmount);
    }


    /**
     * @dev stake函数用于用户质押代币。
     * @param _pid 质押池的ID。
     * @param _amount 要质押的代币数量。
     */
    function stake(uint256 _pid, uint256 _amount) external payable {
        Pool storage pool = pools[_pid];
        User storage user = userInfo[_pid][msg.sender];

        require(_amount >= pool.minDepositAmount, "Amount below minimum");

        updatePool(_pid);

        if (user.stAmount > 0) {
            uint256 pending = (user.stAmount * pool.accRCCPerST) / 1e12 - user.finishedRCC;
            user.pendingRCC += pending;
        }

        if (pool.stTokenAddress == address(0)) {
            // 原生币池
            require(msg.value == _amount, "Incorrect ETH amount sent");
        } else {
            // ERC20 代币池
//            从用户地址向合约地址转移 ERC20 代币
            IERC20(pool.stTokenAddress).transferFrom(msg.sender, address(this), _amount);
        }

        user.stAmount += _amount;
        pool.stTokenAmount += _amount;

        user.finishedRCC = (user.stAmount * pool.accRCCPerST) / 1e12;
        emit Staked(msg.sender, _pid, _amount);
    }

    function unstake(uint256 _pid, uint256 _amount) external {
        Pool storage pool = pools[_pid];
        User storage user = userInfo[_pid][msg.sender];

        require(user.stAmount >= _amount, "Insufficient stake");

        updatePool(_pid);

        uint256 pending = (user.stAmount * pool.accRCCPerST) / 1e12 - user.finishedRCC;
        user.pendingRCC += pending;

        user.stAmount -= _amount;
        pool.stTokenAmount -= _amount;

        user.requests.push(UnstakeRequest({
            amount: _amount,
            unlockBlock: block.number + pool.unstakeLockedBlocks
        }));

        user.finishedRCC = (user.stAmount * pool.accRCCPerST) / 1e12;
        emit Unstaked(msg.sender, _pid, _amount);
    }

    /**
      *@dev claimReward函数用于用户领取RCC奖励。
     * @param _pid 质押池的ID。
     */
    function claimReward(uint256 _pid) external {
        Pool storage pool = pools[_pid];
        User storage user = userInfo[_pid][msg.sender];

        updatePool(_pid);

        uint256 pending = (user.stAmount * pool.accRCCPerST) / 1e12 - user.finishedRCC + user.pendingRCC;
        require(pending > 0, "No reward available");

        rewardToken.transfer(msg.sender, pending);
        user.pendingRCC = 0;
        user.finishedRCC = (user.stAmount * pool.accRCCPerST) / 1e12;

        emit RewardClaimed(msg.sender, _pid, pending);
    }

    /**
     * @dev updatePool函数用于更新质押池的奖励信息。
     * @param _pid 质押池的ID。
     */
    function updatePool(uint256 _pid) internal {
        Pool storage pool = pools[_pid];
        if (block.number <= pool.lastRewardBlock) {
            return;
        }

        if (pool.stTokenAmount == 0) {
            pool.lastRewardBlock = block.number;
            return;
        }

        uint256 multiplier = block.number - pool.lastRewardBlock;
        //计算当前池的总奖励
        uint256 reward = (multiplier * rewardPerBlock * pool.poolWeight) / totalAllocPoint;
            //        更新累计奖励 per 质押代币
        // 	pool.accRCCPerST 表示每单位质押代币的累计奖励。
        //	•	reward / pool.stTokenAmount 计算每个质押代币的新增奖励。
        //	•	乘以 1e12 是为了保留精度，防止除法运算中的精度丢失。
        pool.accRCCPerST += (reward * 1e12) / pool.stTokenAmount;
        pool.lastRewardBlock = block.number;
    }
}