// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 定义一个名为 FunctionModifier 的合约，用于演示函数修饰符的用法
contract FunctionModifier {
    // 声明合约状态变量
    address public owner;     // 存储合约所有者的地址
    uint256 public x = 10;   // 存储一个无符号整数，初始值为 10
    bool public locked;      // 锁定状态，用于防止重入攻击

    // 构造函数：在合约部署时被调用
    constructor() {
        // 将交易发送者设置为合约的所有者
        owner = msg.sender; // msg.sender 是当前调用合约的地址
    }

    // 仅限所有者的修饰符：检查调用者是否为合约的所有者
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner"); // 如果不是所有者，抛出错误
        // 下划线是一个特殊字符，仅在函数修饰符内部使用，
        // 它告诉 Solidity 执行后续代码。
        _; // 执行使用此修饰符的函数的剩余代码
    }

    // 修饰符可以接受输入参数。此修饰符检查传入的地址是否不是零地址
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address"); // 检查地址是否有效
        _; // 执行使用此修饰符的函数的剩余代码
    }

    // 使用 onlyOwner 和 validAddress 修饰符的函数，允许所有者更改合约的所有者
    function changeOwner(address _newOwner)
        public
        onlyOwner             // 仅允许合约所有者调用
        validAddress(_newOwner) // 确保传入的新地址有效
    {
        owner = _newOwner; // 更新合约的所有者地址
    }

    // 防止重入攻击的修饰符：确保函数在执行时不能被再次调用
    modifier noReentrancy() {
        require(!locked, "No reentrancy"); // 检查函数是否已被锁定

        locked = true; // 锁定状态，防止重入
        _; // 执行使用此修饰符的函数的剩余代码
        locked = false; // 函数执行结束，解除锁定
    }

    // 使用 noReentrancy 修饰符的递减函数
    function decrement(uint256 i) public noReentrancy {
        x -= i; // 从 x 中减去 i 的值

        // 如果 i 大于 1，递归调用 decrement 函数
        if (i > 1) {
            decrement(i - 1); // 递归调用，逐步减少 i 的值
        }
    }
}
