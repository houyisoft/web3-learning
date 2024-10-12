// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 定义一个名为 Function 的合约
contract Function {
    // 函数可以返回多个值
    // 返回一个无符号整数、一个布尔值和另一个无符号整数
    function returnMany() public pure returns (uint256, bool, uint256) {
        return (1, true, 2); // 返回具体的值
    }

    // 返回值可以被命名
    // 此函数返回一个无符号整数 x，一个布尔值 b 和另一个无符号整数 y
    function named() public pure returns (uint256 x, bool b, uint256 y) {
        return (1, true, 2); // 返回具体的值，使用命名返回
    }

    // 返回值可以直接赋值给对应的变量
    // 在这种情况下，可以省略返回语句
    function assigned() public pure returns (uint256 x, bool b, uint256 y) {
        x = 1;      // 将 1 赋值给 x
        b = true;   // 将 true 赋值给 b
        y = 2;      // 将 2 赋值给 y
    }

    // 在调用另一个返回多个值的函数时，可以使用解构赋值
    function destructuringAssignments()
        public
        pure
        returns (uint256, bool, uint256, uint256, uint256)
    {
        // 调用 returnMany 函数并使用解构赋值
        (uint256 i, bool b, uint256 j) = returnMany();

        // 可以省略某些返回值
        (uint256 x,, uint256 y) = (4, 5, 6); // 忽略第二个返回值

        // 返回所有的值
        return (i, b, j, x, y); // 返回 i, b, j, x 和 y
    }

    // 不能使用映射作为输入或输出

    // 可以使用数组作为输入参数
    function arrayInput(uint256[] memory _arr) public {}

    // 可以使用数组作为输出
    uint256[] public arr; // 定义一个公开的无符号整数数组

    // 返回存储的数组
    function arrayOutput() public view returns (uint256[] memory) {
        return arr; // 返回数组 arr
    }
}

// 定义一个名为 XYZ 的合约
contract XYZ {
    // 接受多个输入参数的函数
    function someFuncWithManyInputs(
        uint256 x,     // 无符号整数 x
        uint256 y,     // 无符号整数 y
        uint256 z,     // 无符号整数 z
        address a,     // 地址 a
        bool b,        // 布尔值 b
        string memory c // 字符串 c
    ) public pure returns (uint256) {}

    // 调用带有多个输入的函数并返回结果
    function callFunc() external pure returns (uint256) {
        // 调用 someFuncWithManyInputs 函数并传入参数
        return someFuncWithManyInputs(1, 2, 3, address(0), true, "c");
    }

    // 使用键值对调用函数
    function callFuncWithKeyValue() external pure returns (uint256) {
        // 使用键值对语法调用 someFuncWithManyInputs 函数
        return someFuncWithManyInputs({
            a: address(0),  // 地址 a
            b: true,        // 布尔值 b
            c: "c",         // 字符串 c
            x: 1,           // 无符号整数 x
            y: 2,           // 无符号整数 y
            z: 3            // 无符号整数 z
        });
    }
}
