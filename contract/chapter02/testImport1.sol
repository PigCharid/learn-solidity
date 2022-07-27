// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
import "./fatherImp.sol";  //按相对路径本地导入

// contract testImport1{
    
//     FatherImp fatherimp = new FatherImp();

//     function getValue()external view returns(uint){
//         return fatherimp.a();
//     }

//     function getTest()public view returns(string memory){
//         return fatherimp.Test();
//     }
  
// }

// 继承的方式用的更多
contract testImport2 is FatherImp {
    
    function getValue()external view returns(uint){
        return a;
    }
    function getTest()public pure returns(string memory){
        return Test() ;
    }
  
}
