// SPDX-License-Identifier:MIT
pragma solidity ^0.8;


library Math{
    // 注意啊  这里是需要合约内部调用
    function max(uint a,uint b)internal pure returns(uint){
        return a>=b ? a : b;
    }
}


contract Test{
    function testMax(uint a,uint b)external pure returns(uint){
        return Math.max(a,b);
    }
}

library ArrLib{
    function find(uint[] storage arr,uint x)internal view returns(uint){
        for(uint i=0;i<arr.length;i++){
            if(arr[i]==x){
                return i;
            }
        } 
        revert("not find");  
    }
}
contract TestArr{
    using ArrLib for uint[];//库合约的正确使用方式   给类型增强
    uint[] public arr= [12,4,67];
    function testFind(uint b)external view returns(uint){
        //return ArrLib.find(arr,b);
       return arr.find(b);
    }
}