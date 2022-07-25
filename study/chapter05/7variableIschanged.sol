// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract TestVC{
    uint public a =5;

    // 改变了状态变量
    function change(uint _a)external {
        a = _a;
    }

    // 读取了状态变量
    function readV()external view returns(uint){
        return a;
    }

    // 未操作未读取状态变量
    function nothing()external pure returns(string memory){
        return "i do nothing";
    }

    // 还有其他 例如调用内部函数等操作也是被视为读取状态变量
    function other()external {
        address addr = msg.sender;
    }
}