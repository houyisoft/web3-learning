// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 定义一个名为 Error 的合约，用于演示不同的错误处理机制
contract Error {
    // 使用 require 进行输入验证
    function testRequire(uint256 _i) public pure {
        // Require 应用于验证以下条件：
        // - 输入参数
        // - 执行前的条件
        // - 从其他函数调用的返回值
        require(_i > 10, "Input must be greater than 10"); // 如果 _i 小于或等于 10，则抛出错误
    }

    // 使用 revert 进行条件检查
    function testRevert(uint256 _i) public pure {
        // Revert 当需要检查的条件较复杂时非常有用。
        // 该代码的功能与上面的例子完全相同
        if (_i <= 10) {
            revert("Input must be greater than 10"); // 如果 _i 小于或等于 10，则抛出错误
        }
    }

    uint256 public num; // 声明一个公共的无符号整数变量 num

    // 使用 assert 进行内部错误测试
    function testAssert() public view {
        // Assert 应仅用于测试内部错误，
        // 以及检查不变性（invariants）。

        // 这里我们断言 num 始终等于 0，
        // 因为 num 的值不可能被更新
        assert(num == 0); // 如果 num 不等于 0，将抛出错误
    }

    // 自定义错误类型，用于抛出更具体的错误信息
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    // 使用自定义错误进行余额检查
    function testCustomError(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance; // 获取合约当前的余额
        // 检查合约余额是否足够
        if (bal < _withdrawAmount) {
            // 如果余额不足，使用自定义错误进行 revert
            revert InsufficientBalance({
                balance: bal,              // 当前余额
                withdrawAmount: _withdrawAmount // 尝试提取的金额
            });
        }
    }
}
