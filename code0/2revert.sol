pragma solidity ^0.8;

contract test{
    address payable owner = payable(msg.sender);
    function testRevert() public{
        if(msg.sender!=owner){
            revert("error");//gas受提示字符串长度的影响
        }
        owner.transfer(address(this).balance);
    }
}