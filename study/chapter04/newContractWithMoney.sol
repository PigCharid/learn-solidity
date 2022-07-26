// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract testContract{
    // 可接受主币
    receive() external payable{}
    uint public a;

    constructor(uint _a) payable{
        a=_a;
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
contract callContract{
    // 创建了一个合约 注意还没遇实例化，这个时候调用会出错
    testContract t;
    address public contractaddr; 
    function createContractObj(uint amount)public payable{
        t = new testContract{value:amount}(5);
        contractaddr =address(t); 
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}