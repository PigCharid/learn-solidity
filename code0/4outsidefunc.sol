pragma solidity ^0.8;


// 类似使用库函数  合约外部的函数不能有变量的使用
function add(uint x)pure returns(uint){
    return x*2;
}
contract TestFuncOut{
    function testOutFunc(uint x) public pure returns(uint){
        return add(x);
    }
}