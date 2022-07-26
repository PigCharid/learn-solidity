// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testABI1{
    // 获得编码以后的数据  按照ABI的编码规则
    bytes public c = abi.encode(5,1);
    
    uint public d;
    int public e;
    
    constructor(){
        (d,e) = abi.decode(c,(uint,int));
    }
}

contract testABI2{
    //打包以后的数据  没有补0
    bytes public c = abi.encodePacked("5","1");

}

contract testABI3{
    uint public a;

    function add(uint b,uint c) public returns (uint) {
        a=a+b+c;
        return a;
    }

    // 下面两种写法的效果是一致的
    //bytes public encodedABI=abi.encodeWithSelector(this.add.selector,5,1);
    bytes public encodedABI = abi.encodeWithSignature("add(uint256,uint256)",5,1);

    function callFunc()public returns(bool,bytes memory,uint) {
        bool flag=false;
        bytes memory result;
       (flag,result) = address(this).call(encodedABI);
       return (flag,result,a);
    }
   
}