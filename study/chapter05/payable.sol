// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract PayAble{
    address payable public  owner;
    constructor() payable{
        owner = payable(msg.sender); //这里需要用payable强制转化
    }

    // payable修饰函数的话  函数就可以接受链的主币
    function desposit()external payable{
    }
    
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}