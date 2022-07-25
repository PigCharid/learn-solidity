//SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Func{
    function Add(uint x,uint y)external pure returns(uint){
        return x+y;
    }
    // 下面的函数会报错
    // function Use(uint x,uint y)public pure returns(uint){
    //     return Add(x,y);
    // }

    // 内部调用的话，部署以后就不会显示
    function Sub(uint x, uint y)internal pure returns(uint){
        return x-y;
    } 
    function Use(uint x,uint y)public pure returns(uint){
        return Sub(x,y);
    }
}