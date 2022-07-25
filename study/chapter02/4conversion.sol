// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test4{
   
}


contract test3{
   address public addr1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
   address payable public addr2 = payable(addr1);//address 强制转化成address payable
   uint160 public addr3 = uint160(addr1);
   uint160 public addr4 = uint160(address(addr2));//address payable 就不行
   bytes20 public addr6 = bytes20(addr1);
}


contract test2{
   int8 public y = -3; //11111101
   uint8 public x = uint8(y);//这样的强制转化就会出错
   
   uint32 public a = 0x12345678;
   uint16 public b = uint16(a); //高位被截断

   uint16 public a1 = 0x1234;
   uint32 public b1 = uint32(a1); // b 为 0x00001234 now   小转大一般都是没问题的

   bytes2 public a2 = 0x1234;
   bytes1 public b2 = bytes1(a2);  //字节之间的转化是截断低位
}



contract test1{
    uint8 public a = 100;
    uint16 public b = a;//不会溢出 没问题
    uint16 public c= 10;
    //uint8  public d = c;//TypeError: Type uint16 is not implicitly convertible to expected type uint8.
}