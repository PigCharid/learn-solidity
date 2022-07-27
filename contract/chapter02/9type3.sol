// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract type18{
    uint8 public a = 100;
    uint16 public b = a;//不会溢出 没问题
    uint16 public c= 10;
    //uint8  public d = c;//TypeError: Type uint16 is not implicitly convertible to expected type uint8.
}












type UFixed256x18 is uint256;
contract type17{
    uint constant multiplier = 10**18;
    function add(UFixed256x18 a, UFixed256x18 b) internal pure returns (UFixed256x18) {
        return UFixed256x18.wrap(UFixed256x18.unwrap(a) + UFixed256x18.unwrap(b));
    }
    function mul(UFixed256x18 a, uint256 b) internal pure returns (UFixed256x18) {
        return UFixed256x18.wrap(UFixed256x18.unwrap(a) * b);
    }
    function floor(UFixed256x18 a) internal pure returns (uint256) {
        return UFixed256x18.unwrap(a) / multiplier;
    }
    function toUFixed256x18(uint256 a) internal pure returns (UFixed256x18) {
        return UFixed256x18.wrap(a * multiplier);
    }
}


contract type16{
    uint public a = 10;//stroage类型

    function foo()public  pure returns(uint){
        uint b = 10;
        //uint storage c  = a;   只能为数组、结构或映射类型指定数据位置  
        return b;
    }
}
contract type15{
    function foo() public pure returns(uint){
        uint a =5;
        return a;
    }
    function () external returns(uint) f=this.foo;// f=this.foo;注意无法这样赋值，只能初始化时赋值

    function getAddr()external view returns(address){
        return this.foo.address;
        //return f.address;
    }
    function getSekector() public view returns(bytes4){
        //return this.foo.selector;
        return f.selector;
    }

}



contract Enum{
    enum Status{
        None,
        Pendding,
        Canceled
    }
    //定义枚举  他就是一种类型
    Status public status;
    Status public max = type(Status).max;
    Status public min = type(Status).min;
    struct Order{
        address buyer;
        Status status;
    }
    Order[] public orders;
    function get() external view returns(Status){
        return status;
    }
    function set(Status _status) external {
        status = _status;
    }
    function canceled()external{
        status = Status.Canceled;
    }
    // 枚举的默认值就是第一个值
    function reset()external{
        delete status;//删除以后就是默认值
    }
}
contract type13{
    receive() external payable{}
    uint public a;
    function getContractName()external pure returns(string memory){
        return "type13";
    }
    function setA(uint _a)external{
        a = _a;
    }
}
contract type14{
    // 这种   先部署type13然后通过类型和地址也能获得一个合约类型
    type13 public t = type13(payable(0xE5f2A565Ee0Aa9836B4c80a07C8b32aAd7978e22));
    // 这里是创建了一个合约
    //type13 t = new type13();
    address public contractaddr = address(t);  //可以获取创建的合约地址
    string public str = t.getContractName();
    function setA(uint _a)external {
        t.setA(_a);
    }
    string public str1 = type(type13).name;
    bytes public by = type(type13).creationCode;
}





contract type12{

    receive() external payable{}
    address public addrNotPayable = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address payable public addr =payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address public contractAddr = address(this);

    function getBalance(address _account)external view returns(uint){
        return _account.balance;
    }

    function myTransfer(address payable _to,uint _amount)external {
      //  addrNotPayable.transfer(100); "send" and "transfer" are only available for objects of type "address payable", not "address".
        _to.transfer(_amount);
    }
    function mySend(address payable _to,uint _amount)external {
      //  addrNotPayable.send(100); "send" and "transfer" are only available for objects of type "address payable", not "address".
        _to.send(_amount);  //Warning: Failure condition of 'send' ignored. Consider using 'transfer' instead.
    }
}



contract type11{
   address public addrNotPayable = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
   address public addr = payable(addrNotPayable);
   address public contractAddr = address(this);
   
    // 为什么得出的结果是一样的
   bytes32 public by1 = addrNotPayable.codehash;
   bytes32 public by2 = addr.codehash;
   bytes32 public by3 = contractAddr.codehash;


   
   uint public balance1 = addrNotPayable.balance;
   uint public balance2 = addr.balance;
   uint public balance3 = contractAddr.balance;

   bytes public b1 = addrNotPayable.code;
   bytes public b2 = addr.code;
   bytes public b3 = contractAddr.code;
   bytes32 public b4 =   keccak256(contractAddr.code);

   function getByte()external view returns(bytes memory,bytes memory,bytes memory){
       return (addrNotPayable.code,addr.code,contractAddr.code);
   }
   
}








contract type10{
   bytes1 public a = 0x11;   //16进制 一个占四位
   uint public len =  a.length;

}


contract type9{
   fixed8x4  a; 
}

contract type8{
   //111   前面还有253个0
   uint i1 = 7;
   // 像右移动一位，舍去一个1 11 前面254个0   值为3
   uint public i2 = i1>>1;
   // 像左移动一位，低位用0补齐 1110 前面252个0   值为14
   uint public i3 = i1<<1;
   //等价于右移一位
   uint public i4 = i1/2**1;
   //等价于左移一位
   uint public i5 = i1*2**1;
   //256个1
   uint public max  = type(uint).max;
   //255个1加1个0  其实值小了一 最高位被截断了一位
   uint public i6 = max<<1;//编译器不会报错  结果也不会检查  所以在进行移位运算的时候注意要检查
     
   uint public min  = type(uint).min;
   //0
   uint public i7 = min>>2;//编译器不会报错  结果也不会检查  所以在进行移位运算的时候注意要检查
   
   // 01111111
   int8 public maxI8 = type(int8).max;
   // 10000000
   int8 public minI8 = type(int8).min;

   //00111111    
   int public i8 = maxI8>>1;
   //11111110 
   int public i9 = maxI8<<1;
   // 11000000
   int public i10 = minI8>>1;
   // 00000000
   int public i11 = minI8<<1;
}




contract type7{
    uint public a= 10**18;
    //uint public a= 10**256; 溢出
}


contract type6{
    uint i1 = 5;
    uint i2 = 2;
    uint public i3 = i1%i2;
}


contract type5{
    // 规定后六位是小数
    uint i1 = 1000000;
    function mycal(uint _param)external view returns(uint){
        return i1/_param;
    }
    // 1000000/4 = 250000  后六位是小数  按规定250000则为0.25
}

contract type4{
    //1/4*4的话 会得到0   
    uint public i1 = 1; 
    function mycal(uint _param)external view returns(uint){
        return i1/_param*_param;
    }
    //精度
    uint public accuracy =100;
    //在产生小数截断的地方扩大，结果初缩小 可以结果小数截断的问题
    function mycalPlus(uint _param)external view returns(uint){
            return i1*accuracy/_param*_param/accuracy;
    }
}




contract type3{
    uint public i1 = type(uint).min-1;  //编译器不会发现  但是部署的时候会报错
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




contract type2{
    //uint8 i1 = 257;   越界
    uint public max = type(uint).max;
    uint public min = type(uint).min;
 
    int public maxI= type(int).max;
    int public minI= type(int).min;

    uint public i1;
    function setI1(uint _i1)external {
        require(_i1<=max,"up over");
        i1 = _i1;
    }
}
