// SPDX-License-Identifier:MIT
pragma solidity ^0.8;


contract Event{
    event Log(string message,uint val);

    // 事件中可以添加很多的变量参数，但是不能超过三个
    event indexedLog(address indexed sender,uint val);

    // 引入了事件的话  就不能使用view  或者pure的关键字了
    function example()external{
        emit Log("wp",15000);
        emit indexedLog(msg.sender,13000);
    }

    event Message(address indexed _from,address indexed _to,string message);
    function example1(address _to,string calldata _message)external{
        emit Message(msg.sender,_to,_message);
    }
}