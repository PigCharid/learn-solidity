// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Modifier{
    bool public paused;
    uint public count;
    function setP(bool _pause)external {
        paused = _pause;
    }
    modifier WhenPaused(){
        require(!paused,"already paused");
        _;
    }
    function add()external WhenPaused{
        count++;
    }

    modifier check(uint x){
        require(x<100,"x>100");
        _;
    }

    function addBy(uint x)external WhenPaused check(x){
        count+=x;
    }


    // 三明治写法
    modifier sandwitch(){
        count+=10;
        _;
        count = count*2;
    }
    function sandwitchTest()external  sandwitch{
        count+=1;
    }

}