// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testAssignment{
    uint index;

    function f() public pure returns (uint, bool, uint) {
        return (7, true, 2);
    }

    function g() public {
        //基于返回的元组来声明变量并赋值
        (uint x, bool b, uint y) = f();
        //交换两个值的通用窍门——但不适用于非值类型的存储 (storage) 变量。
        (x, y) = (y, x);
        //元组的末尾元素可以省略（这也适用于变量声明）。
        (index,,) = f(); // 设置 index 为 7
    }
}