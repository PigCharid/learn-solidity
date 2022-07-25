// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testDel{
    uint[] public arr = [1,2];

    function remove(uint _index)public {
       uint len = arr.length;
        arr[_index] = arr[len-1];
        arr.pop();
    }
    function returnArr()external view returns(uint[] memory){
        return arr;
    }

    function test()external{
        remove(1);
        assert(arr.length ==2);
        assert(arr[1]==3);
    }

}