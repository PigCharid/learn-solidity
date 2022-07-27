// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testReturn{
    // 未给返回参数取名字
    function returnMany()public pure returns(uint,bool){
        return (1,true); 
    }
    // 返回参数取了名字
    function named()public pure returns(uint x,bool b){
        return(1,true);
    }

    // 返回参数取了名字可以不用加return  但是建议加上   更加清晰
    function assigned()public pure returns(uint x,bool b){
        x=1;
        b=true;
    }
    // 通过返回值进行函数调用
    function useReturn()external pure{
        (uint _x,bool _b) = returnMany();
        (,bool _c) = returnMany();  //类似Go中的省略s

    }
}