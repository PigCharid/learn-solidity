// SPDX-License-Identifier:MIT
pragma solidity ^0.8;


contract Fallback{
    // event Log(string func,address sender,uint value,bytes data);
    // // 有data的话会触发fallback
    // fallback()external payable{
    //     emit Log("fallback",msg.sender,msg.value,msg.data);
    // }
    // // 没有data会触发receive
    // receive() external payable{
    //     emit Log("receive",msg.sender,msg.value,"");
    // }//必须加上payable 是用来处理钱回退的处理

     event Log(uint a,address caller);
    receive()external payable{
        emit Log(8,msg.sender);
    }

    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}

contract SendEth{
    constructor() payable{

    }
    receive() external payable{}
    function sendViaTransfer(address payable _to)external payable {
        _to.transfer(1);//发的是123个wei
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}