// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract Company{
    function moneyTest()external pure{
       assert(1 wei == 1);
       assert(1 gwei == 1e9);
       assert(1 ether == 1e18); 
    }
}