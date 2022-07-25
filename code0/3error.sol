pragma solidity ^0.8;
// error errorAuth(address caller);//在报错中会有一种固定的范湖方式  也可以定义在外部
contract Test{
    error errorAuth(address caller);//在报错中会有一种固定的范湖方式
    address payable owner = payable(msg.sender);
    function testError()public{
        if(msg.sender!=owner){
            revert errorAuth(msg.sender);//这种错误返回会节约gas  
        }
        owner.transfer(address(this).balance);
    }
}