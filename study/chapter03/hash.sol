// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testHash{
    uint public a;
    function add(uint b) public {
        a+=b;
}
    
    // 下面两种写法是效果是一样的  是ABI编码规则中函数名编码的前四个字节
    bytes4 public selector = this.add.selector;
    bytes4 public genSelector = bytes4(keccak256("add(uint256)"));
    bool public isequal = (selector==genSelector);
    
    bytes32 public sha = sha256("add(uint256)");
    bytes32 public ripemd = ripemd160("add(uint256)");
}