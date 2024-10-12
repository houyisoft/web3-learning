// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Variables  {

    // 在区块链上部署一个名为numa的变量，占用一个位置
    uint256 public num;

    // You need to send a transaction to write to a state variable.
    function set(uint256 _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint256) {
        return num;
    }

}