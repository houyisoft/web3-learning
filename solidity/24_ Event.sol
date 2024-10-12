// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 定义一个名为 Event 的合约，用于演示事件的使用
contract Event {
    // 事件声明
    // 最多可以有 3 个参数被索引
    // 索引参数有助于通过索引参数过滤日志
    event Log(address indexed sender, string message); // 定义 Log 事件，包含发送者地址和消息
    event AnotherLog(); // 定义另一个事件，没有参数

    // 测试函数：用于触发事件
    function test() public {
        // 触发 Log 事件，传入当前调用者的地址和一条消息
        emit Log(msg.sender, "Hello World!"); // 发送 "Hello World!" 消息
        emit Log(msg.sender, "Hello EVM!");   // 发送 "Hello EVM!" 消息
        emit AnotherLog(); // 触发 AnotherLog 事件
    }
}
