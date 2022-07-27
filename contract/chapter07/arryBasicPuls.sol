// SPDX-License-Identifier:MIT

pragma solidity ^0.8;

contract testArray{
    uint[] public num;
    uint[3] public numFixed = [1];
    function arryReturn()external  returns(uint[] memory ){
        num.push(1);
        num.push(2);
        //uint[] memory a = num;  //如何把状态变量复刻下来
        uint[] storage a = num;  //如何把状态变量复刻下来
        a[0]=5;   
        return num;
        //return a;
    }

}