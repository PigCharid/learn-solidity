pragma solidity ^0.8;

contract safemath{
   function testWithNoUncheck() public pure returns(uint) {
       uint a = 0;
       a--; //存在向下溢出
       return a;
   }
   function testWithUncheck()public pure returns(uint){
       uint a = 0;
       unchecked{a--;}//这个溢出的话就不会检验
       return  a;
   }
}