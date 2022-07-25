// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract back{
    event Log(string func,address sender,uint value);
    //有data的话会触发fallback
    fallback()external payable{
        emit Log("fallback",msg.sender,msg.value);
    }
    // 没有data会触发receive
    receive() external payable{
        emit Log("receive",msg.sender,msg.value);
    }//必须加上payable 是用来处理钱回退的处理

    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
