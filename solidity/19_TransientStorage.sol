// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 确保 EVM 版本设置为 Cancun
// Storage - 数据存储在区块链上
// Memory - 数据在函数调用结束后被清除
// Transient storage - 数据在交易结束后被清除

// ITest 接口，定义了两个外部函数：val 和 test
interface ITest {
    // 返回一个 uint256 类型的值
    function val() external view returns (uint256);
    // 执行 test 函数
    function test() external;
}

// Callback 合约，处理外部合约调用的回调逻辑
contract Callback {
    // 定义一个公开的 uint256 类型的变量 val
    uint256 public val;

    // fallback 函数：当调用未定义的函数时被触发
    fallback() external {
        // 获取调用者合约的 val 值并赋值给当前合约的 val
        val = ITest(msg.sender).val();
    }

    // test 函数：调用目标合约的 test 函数
    function test(address target) external {
        // 调用目标合约的 test 函数
        ITest(target).test();
    }
}

// TestStorage 合约，用于测试普通存储
contract TestStorage {
    // 定义一个公开的 uint256 类型的变量 val
    uint256 public val;

    // test 函数：修改 val 并执行外部调用
    function test() public {
        val = 123; // 设置 val 为 123
        bytes memory b = ""; // 定义空的字节数组

        // 进行低级调用 msg.sender.call 并捕获返回结果
        (bool success, ) = msg.sender.call(b);

        // 确保调用成功，如果失败则抛出错误
        require(success, "Call failed");
    }
}

// TestTransientStorage 合约，用于测试瞬态存储
contract TestTransientStorage {
    // 定义瞬态存储的槽位常量
    bytes32 constant SLOT = 0;

    // test 函数：使用瞬态存储并执行外部调用
    function test() public {
        // 使用内联汇编直接操作瞬态存储
        assembly {
            // 将 321 存储在瞬态存储槽位
            tstore(SLOT, 321)
        }

        // 执行外部调用
        bytes memory b = "";
        (bool success, ) = msg.sender.call(b);

        // 确保调用成功
        require(success, "Call failed");

        // 调用结束后显式清除瞬态存储
        assembly {
            // 重置瞬态存储槽位为 0
            tstore(SLOT, 0)
        }
    }

    // val 函数：读取瞬态存储中的值
    function val() public view returns (uint256 v) {
        // 使用内联汇编直接从瞬态存储中加载值
        assembly {
            v := tload(SLOT)
        }
    }
}

// ReentrancyGuard 合约，用于防止重入攻击
contract ReentrancyGuard {
    // 定义一个布尔类型的锁，初始值为 false
    bool private locked;

    // 定义锁的修饰符，防止重入
    modifier lock() {
        // 确保没有重入，如果锁已被激活则抛出异常
        require(!locked);
        locked = true; // 激活锁
        _; // 执行函数主体
        locked = false; // 函数执行完毕后解锁
    }

    // test 函数：使用 lock 修饰符防止重入
    // 消耗 35313 gas
    function test() public lock {
        // 忽略外部调用的错误
        bytes memory b = "";
        (bool success, ) = msg.sender.call(b);

        // 确保调用成功
        require(success, "Call failed");
    }
}

// ReentrancyGuardTransient 合约，结合瞬态存储防止重入攻击
contract ReentrancyGuardTransient {
    // 定义瞬态存储的槽位常量
    bytes32 constant SLOT = 0;

    // 定义基于瞬态存储的锁的修饰符，防止重入
    modifier lock() {
        // 使用内联汇编从瞬态存储中读取锁状态
        assembly {
            // 如果锁定状态为 1，则抛出异常，防止重入
            if tload(SLOT) { revert(0, 0) }
            // 将锁定状态设置为 1，表示已锁定
            tstore(SLOT, 1)
        }
        _; // 执行函数主体
        assembly {
            // 函数执行完毕后重置锁定状态为 0
            tstore(SLOT, 0)
        }
    }

    // test 函数：使用瞬态存储锁防止重入
    // 消耗 21887 gas
    function test() external lock {
        // 忽略外部调用的错误
        bytes memory b = "";
        (bool success, ) = msg.sender.call(b);

        // 确保调用成功
        require(success, "Call failed");
    }
}