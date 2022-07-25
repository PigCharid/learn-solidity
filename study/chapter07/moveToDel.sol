// SPDX-License-Identifier:MIT

pragma solidity ^0.8;

contract testArry{
    uint[] public arr;
    function example()external {
        arr= [1,2,3];
        delete arr[1];  //arr = [1,0,2]
    }
    // 其实想要的效果是 删除一个 变成[1,3]

    // 想法  就是  先移动 然后再pop一下   这种方法浪费gas
    function remove(uint _index)public{
        require(_index<arr.length,"error _index");
        for (uint i =_index;i<arr.length-1;i++){
            arr[i]=arr[i+1];
        }
        arr.pop();
    } 

    function test()external{
        arr=[1,2,3];
        remove(1);
        // assert(arr[2]==3);
        // assert(arr.length==2);

    }
}