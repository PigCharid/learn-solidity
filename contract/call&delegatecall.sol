// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

// 发起调用的合约
contract EthAlice {
    uint    public num;
    address public addr;
    function callSetNum(address ads, uint value) public returns(bool success,bytes memory data) {
        
        (success,data) =ads.call(abi.encodeWithSignature("SetNum(uint256)",value));

    }

    function delegatecallSetNum(address ads, uint value) public returns(bool success,bytes memory data) {
        
        (success,data) =ads.delegatecall(abi.encodeWithSignature("SetNum(uint256)",value));

    }
   
}

// 被调用的合约
contract EthBob {
    uint    public num;
    address public addr;

    event sendAddr(address);
    function SetNum(uint _num) public {
        num = _num;
        addr = msg.sender;
        emit sendAddr(msg.sender);
    }
}
