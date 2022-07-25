pragma solidity ^0.8;

import {TestFuncOut,add as a} from "./4outsidefunc.sol";
// 起别名来解决了命名冲突的问题
function add(uint x) pure returns(uint){
        return x;
    }
contract TestNewName{
    function testNN(uint x)public pure returns(uint){
        return add(x);
    }
   
}