// SPDX-License-Identifier:MIT
pragma solidity ^0.8;


contract ETHReceiver{
    event Log(uint amount,string func,address to);
    // 有回退函数的话   合约地址才能接受转账  或者是call的是传入主币
    receive()external payable{
        emit Log(msg.value,"func",msg.sender);
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
contract SendEth{
    constructor() payable{

    }
    function sendViaTransfer(address payable _to)external  {
        _to.transfer(123);//发的是123个wei
    }
    function sendViaSend(address payable _to)external  {
        bool success = _to.send(123);
        require(success,"send fail");
    }
    function sendViaCall(address payable _to)external  {
       (bool success,)= _to.call{value:123}("");//注意语法的不一样  后面的括号指的是附带的数据
       require(success,"call fail");
    }
     function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
