// SPDX-License-Identifier:MIT
pragma solidity ^0.8;



contract selfDestruct{
    constructor()payable{

    }
    function kill()external {
        // 将合约中的主币发送出去   不接受主币的合约地址 也会被强制接受 
        selfdestruct(payable(msg.sender));
    }

    function test()external pure returns(uint){
        return 123;
    }
}