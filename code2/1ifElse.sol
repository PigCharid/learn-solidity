// SPDX-License-Identifier:MIT
pragma solidity 0.8;

contract IfElse{
    // if()
    // 发现在合约中不能直接使用if判断 要在函数中才行
    function control(uint x)external pure returns(uint){
        if(x<2){
            return 100;
        }else if(x<5){
            return 200;
        }else{
            return 300;
        }
    }
    function ternaryOpration(uint x)external pure returns(uint){
        return x<3 ? 100:200;
    }
}