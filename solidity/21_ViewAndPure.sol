// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 定义一个名为 ViewAndPure 的合约
contract ViewAndPure {
    // 定义一个公共的无符号整数变量 x，初始化为 1
    uint256 public x = 1;

    // 函数 addToX：承诺不修改合约状态
    // 该函数接受一个无符号整数 y 作为参数
    // 返回 x 和 y 的和
    function addToX(uint256 y) public view returns (uint256) {
        // 读取状态变量 x 的值，并将其与 y 相加
        return x + y; // 返回 x 和 y 的和
    }

    // 函数 add：承诺不修改或读取合约状态
    // 该函数接受两个无符号整数 i 和 j 作为参数
    // 返回 i 和 j 的和
    function add(uint256 i, uint256 j) public pure returns (uint256) {
        // 直接返回 i 和 j 的和，不涉及状态变量
        return i + j; // 返回 i 和 j 的和
    }
}
