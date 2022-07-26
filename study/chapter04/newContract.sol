// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract testContract{
    uint public a;
    constructor(uint _a) payable{
        a=_a;
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
    
    function getContractName()external pure returns(string memory){
        return "testContract";
    }
    function setA(uint _a)external{
        a = _a;
    }
}
contract callContract{
    // 创建了一个合约 注意还没遇实例化，这个时候调用会出错
    testContract t;
    address public contractaddr;//合约地址
    string public contractName;//合约名字 
     // type(合约类型)   可以获取合约的相关的参数
    string public str1;
    bytes public by;
    function createContractObj(uint amount)public payable{
        t = new testContract{value:amount}(5);
       
    }
     function initParams()external {
        contractaddr =address(t); 
        contractName = t.getContractName();
        str1 = type(testContract).name;
        by = type(testContract).creationCode;
    }
    function setA(uint _a)external {
        t.setA(_a);
    }
    function getA()external view returns(uint){
        return t.a(); //通过public生成的getter方法读取状态变量
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
   
}