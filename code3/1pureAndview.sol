// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract PAndV{
    uint public num = 1;
    function ViewFunc()public view returns(uint){
        return num ;
    }
    function PureFunc() public pure returns(uint){
        // return num;   //pure不能读取状态变量
        return 1;
    }
}