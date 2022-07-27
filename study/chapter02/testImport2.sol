// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
//import {FatherImp as newname} from "./4fatherImp.sol";
import {outside as o} from "./fatherImp.sol";  //对fatherImp中的outside取别名

function outside()pure returns(uint){
    return 1;
}
// contract testImport3 is newname {
   
// }
contract testImport4 {

}