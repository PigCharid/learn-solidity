// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract Base {
    uint x;
    constructor(uint x) { x = x; }
}

// 直接在继承列表中指定参数
contract Derived1 is Base(7) {
    constructor() {}
}

// 或通过派生的构造函数中用 修饰符 "modifier"
contract Derived2 is Base {
    constructor(uint y) Base(y * y) {}
}