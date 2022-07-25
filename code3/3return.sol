// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testReturn{
    function returnMany()public pure returns(uint,bool){
        return (1,true);
    }
    function named()public pure returns(uint x,bool b){
        return(1,true);
    }

    // 可以不用加上ruturn  但是建议加上   更加清晰
    function assigned()public pure returns(uint x,bool b){
        x=1;
        b=true;
    }
    function useReturn()external pure{
        (uint _x,bool _b) = returnMany();
        (,bool _c) = returnMany();  //类似Go中的省略s

    }
}