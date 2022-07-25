// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Test1{
    address public owner = msg.sender;
    function setOwner(address newOwner)public{
        require(msg.sender == owner,"cant not use this");
        owner = newOwner;
    }
}

contract Test2{
    address public owner  = msg.sender;
    uint public x;
    uint public y;
    uint public value =msg.value;
    // payable 的意思是可以发送主币
    constructor(uint _x,uint _y) payable{
        x = _x;
        y = _y;
    }
}

contract Proxy{
   event Deploy(address);
   fallback() external payable{}
    receive()external payable{}

   function deploy(bytes memory _code)external payable returns(address addr){
    //    内联汇编部署合约  这是个固定写法
       assembly{
        //    create(v,p,n)
        //  v  表示部署合约发送主币的数量
        //      p  机器码在内存中开始的位置
        // n  机器码的大小
        // 下面三个参数  都是内联汇编中的写法
        addr:=create(callvalue(),add(_code,0x20),mload(_code))
       }
       require(addr != address(0),"deploy fail");
       emit Deploy(addr);
   }
   function excte(address target,bytes memory _data)external payable {
       (bool success,)=target.call{value:msg.value}(_data);
       require(success,"failed");
   }
}

contract Help{
    // 不需要构造函数的
    function getByteCode1()external pure returns(bytes memory){
        bytes memory bytecode = type(Test1).creationCode;
        return bytecode;
    }
    function getByteCode2(uint _x,uint _y)external pure returns(bytes memory){
        bytes memory bytecode = type(Test2).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_x,_y));
    }
    function getCalldate(address _owner)external pure returns(bytes memory){
        return abi.encodeWithSignature("setOwner(address)",_owner);
    }
}