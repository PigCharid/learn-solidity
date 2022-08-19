// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
pragma abicoder v2;

contract useAbicodeV2{
    struct People{
        string name;
        uint  age;
    }    

    People[] public peoples;

    function _setAllPeopleName()public view returns(People[] memory p){
        p = peoples;
        for(uint i = 0;i<p.length;i++){
            p[i].name="metamarvel";
        }
    }

    function addPeople()public {
        People memory a = People("wp",25);
        People memory b = People("zt",24);
        peoples.push(a);
        peoples.push(b);
    }
     function getPeople()public view returns(People[] memory p){
        return peoples;
    } 
}