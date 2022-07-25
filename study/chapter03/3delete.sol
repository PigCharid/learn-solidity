// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract DeleteExample {
    uint public data = 1;
   uint[] public arrydata =[1,2];

    function deldata()external {
        delete data;
    }
    // 不影响数组长度 删除的元素置为默认值
    function delarrydata0()external {
        delete arrydata[0];
    }
    //直接删除数组的话  会导致数组的长度变成0
    function delarrydata()external {
        delete arrydata;
    }
}