// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 基础合约 X
contract X {
    string public name; // 存储合约名称

    // 构造函数：初始化合约名称
    constructor(string memory _name) {
        name = _name; // 将输入的名称赋值给状态变量
    }
}

// 基础合约 Y
contract Y {
    string public text; // 存储文本信息

    // 构造函数：初始化文本信息
    constructor(string memory _text) {
        text = _text; // 将输入的文本赋值给状态变量
    }
}

// 有两种方法可以用参数初始化父合约

// 第一种方法：在继承列表中传递参数
contract B is X("Input to X"), Y("Input to Y") {} // 合约 B 继承 X 和 Y，并传递初始化参数

// 第二种方法：在子合约的构造函数中传递参数，类似于函数修饰符
contract C is X, Y {
    // 构造函数：初始化父合约 X 和 Y
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// 父合约的构造函数总是按继承顺序调用
// 不论子合约构造函数中列出的父合约顺序如何

// 构造函数调用顺序：
// 1. X
// 2. Y
// 3. D
// Order of constructors called:
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

// Order of constructors called:
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}