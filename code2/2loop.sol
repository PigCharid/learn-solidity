// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract Loop{
    uint public a;
    function Loops()external {
        uint i=0;
        for (i=0;i<5;i++){
            if(i == 3){
                continue;
            }
            if (i==5 ){
                break;
            }
            a++;   
        }
        while(i<=6){
            i++;
            a++;  //012456
        }
    }

    function sum(uint n)external pure returns(uint){
        uint _sum;
        for(uint i=0;i<=n;i++){
            _sum+=i;
        }
        return _sum;
        
    }

}