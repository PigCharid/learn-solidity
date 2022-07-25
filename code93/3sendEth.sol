// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract SendEth{
    constructor() payable{

    }
    receive() external payable{}
    function sendViaTransfer(address payable _to)external payable {
        _to.transfer(123);//发的是123个wei
    }
    function sendViaSend(address payable _to)external payable {
        bool success = _to.send(123);
        require(success,"send fail");
    }
    function sendViaCall(address payable _to)external payable {
       (bool success,)= _to.call{value:123}("");//注意语法的不一样  后面的括号指的是附带的数据
       require(success,"call fail");
    }

}
contract ETHReceiver{
    event Log(uint amount,uint gas);
    receive()external payable{
        emit Log(msg.value,gasleft());
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}