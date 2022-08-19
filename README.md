# 第一章：简介

## 1、基本概念

### 1.1什么是智能合约

​		智能合约（Smart Contract）是上世纪90年代由密码学家尼克·萨博提出的理念，由于当时缺乏可信的执行环境，智能合约没有被应用和发展，直到以太坊的出现，才让智能合约得以“复活”，也就是以太坊中对智能合约进行了实现，以太坊中，就是通过智能合约去改变、读取区块链上的数据。

​		不要把智能合约想的有多么的复杂，其实一个智能合约就是一个脚本，那实现这个脚本的变成语言就是solidity，v神自己也曾发过推特，后悔取智能合约这个名字了

### 1.2什么是solidity

​		看一下官方文档给的解释

​		Solidity is an object-oriented, high-level language for implementing smart contracts. Smart contracts are programs which govern the behaviour of accounts within the Ethereum state.

​		solidity是实现智能合约的面向对象的高级编程语言，智能合约是通过账户行为来管理以太坊链上数据的状态

​		其实就是通过用户调用智能合约去操作存储在链上的数据

​		目前solidity的版本更新也是比较的快，我们学习采用的是最新的0.8版本。

### 1.3推荐网站

​		本课程是solidity开发课程，其他的基本区块链基础概念，像区块、交易、账户、钱包等基础概念如果有不理解的，请自行去学习区块链的基础知识，下面是几个推荐的学习资料

```
https://github.com/inoutcode/bitcoin_book_2nd       精通比特币
https://github.com/inoutcode/ethereum_book        	精通以太坊
https://ethereum.org/en/														以太坊官网
https://docs.soliditylang.org/en/v0.8.10/						solidity官方文档
```

## 2、开发工具—Remix

### 2.1介绍

```
https://remix.ethereum.org     官网
```

remix是一款在线的专门用于智能合约发开的开发工具，输入网址就可以打开

同时remix也提供了测试网络的环境，直接可以编译并部署在测试环境中

### 2.2如何链接本地

```
安装remix的文件客户端管理器
npm install @remix-project/remixd     //需要自己提前安装nodejs

remixd --version    //验证是否安装成功

remixd -s fileURL -u webURL   //开启remixd

打开网站，选择localhost
```

remixd的更多功能介绍可以看官方的文档 https://remix-ide.readthedocs.io/en/latest/#

## 3、HelloWorld

智能合约文件都是以`.sol`结尾，接下来我们来说实现第一智能合约

定义一个链上的字符串存储空间space，并且赋值”Hello World“，提供一个获取该状态变量值的接口方法

`HelloWorld.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract MyFirstSmartContract{
		//public 修饰的变量部署以后默认有一个get的方法
    string public space = "Hello World";
    function getSpace()external view returns(string memory){
        return space;
    }
}
```

# 第二章：基本结构和数据类型

## 1、基本结构

用solidity编写的智能合约是以.sol结尾的文件，文件内容就是由一个一个`contract`关键字定义的合约组成

`basicStruct.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract Example{
    //合约实现
}

contract Example1{
    //合约实现
}
```

### 1.1版权许可标志

代码许可的标识参考 https://spdx.dev/ids/#how

一般我们只需要将使用`// SPDX-License-Identifier:MIT`即可

如果你不想指定一个许可证，或者如果源代码不开源，请使用特殊值 `UNLICENSED`

每个源文件都应该以这样的注释开始以说明其版权许可证，如果不添加的话，编译的时候会弹出警告

### 1.2编译器版本标识

版本 标识pragma 指令通常只对本文件有效，所以我们需要把这个版本 标识pragma 添加到项目中所有的源文件。 如果使用了 `import `导入其他的文件, 标识pragma 并不会从被导入的文件，加入到导入的文件中

指定被导入的文件的编译器版本是0.8.1

`oneCompiler.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity 0.8.1;  
contract oneCompiler{
}
```

在该目录下创建otherCompiler.sol指定编译器的版本为0.8.0，同时引入上面的创建的智能合约，就会报错，这就需要调整一下版本的指定

`otherCompiler.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity 0.8.0;  
import "./oneCompiler.sol";
contract otherCompiler{
}

```



版本修饰符号

```
如果指定编译器的版本的话，就不用添加版本修饰符号
^  //表示大于该版本的编译器独都是可以的
> = < //符号也是使用的
支持范围指定   指定0.8的话，那么0.8.x版本的编译器都是可以的
```

`compilerVersion.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity >=0.4.22 <0.7.0;

contract compilerVersion{
    //合约实现
}
```



启动实验性功能

从Solidity 0.7.4开始， ABI coder v2 不在作为实验特性，而是可以通过``pragma abicoder v2`` 启用，具体开启abicoder v2多了哪些功能设置，后面我继续补充，目前发现导入以后可以把结构体数组复杂数据作为函数的参数传入

`useAbicodeV2.sol`

```solidity
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
```



### 1.3合约文件的导入

合约文件支持从外部导入合约文件，文件夹路径下也支持相对路径的文件导入，同时支持起别名

#### 1.3.1本地导入

创建一个fatherImp.sol作为被导入的脚本文件，设置一个变量值，提供一个函数，供测试使用

`fatherImp.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
contract FatherImp{
    uint  public a = 100;
    function Test()public pure returns(string memory ){
        return "this is a test";
    }
}
```

创建testImport.sol，按相对路径的方式导入本地的合约文件，导入合约以后，调用合约内容的方式整理两种，第一只种是创建合约对象，通过合约对象进行调用，这里我们看到用`contract`定义的也是一种类型，属于合约类型，后面会详细介绍；第二种是通过继承，那么子合约就能访问父合约开放权限的资源，关于继承的知识后面也会详细介绍

`testImport1.sol`

```solidity
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

```

同时支持起别名

创建testImport2.sol，导入fatherImp.sol并取别名，在{}里面进行取别名，当存在命名冲突的时候，就可以进行取别名

`testImport2.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
import {FatherImp as newname} from "./fatherImp.sol";  //按相对路径本地导入，并且给合约起别名
 
contract testImport3 is newname {
}
```

对testImport2.sol进行修改，添加一个合约外部函数（0.8的新特性，类似库函数，后面会详细介绍）



```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
//import {FatherImp as newname} from "./4fatherImp.sol";
import "./4fatherImp.sol";  //按相对路径本地导入

function outside()pure returns(uint){
    return 1;
}
// contract testImport3 is newname {
   
// }
contract testImport4 {   
}
```

同时在fatherImp.sol添加相同的外部函数

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
function outside()pure returns(uint){
    return 1;
}
contract FatherImp{
    uint   a = 100;
    function Test()public pure returns(string memory ){
        return "this is a test";
    }
}
```

这时候我们发现报错

![image-20220705104155434](/Users/yunphant/Desktop/%E5%AD%A6%E8%80%8C%E5%AE%9E%E4%B9%A0%E6%97%B6/%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6/image-20220705104155434.png)

这个时候我们就可以对父类合约的外部函数取别名

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
//import {FatherImp as newname} from "./4fatherImp.sol";
import {outside as o} from "./4fatherImp.sol";  //对fatherImp中的outside取别名

function outside()pure returns(uint){
    return 1;
}
// contract testImport3 is newname {
// }
contract testImport4 {
}
```

#### 1.3.2远程导入

合约脚本的导入同时支持远程的库导入，下面我们试一下远程导入openzepplin的ERC721，什么是openzepplin，openzepplinOpenZeppelin Contracts 是一个用于安全智能合约开发的库，该库里面有很多合约脚本的实现，引入了远程的库合约脚本

`testImport3.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract testImport5 is ERC721 {
    constructor() ERC721("MyCollectible", "MCO") {
    }
}
```

`testImport4.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.6;  
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/cryptography/ECDSA.sol";
contract testImport6 {
    using ECDSA for bytes;
}
```

###  1.4合约

通常把contract修饰结构部分称作一个合约，合约里面主要包含状态变量、函数、函数修改器、事件、错误、结构体、枚举类型

`contractContent.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract contractContent{
    uint public a; //存储上链的数据称为状态变量
    //函数
    function example()external pure returns(string memory){
        return "i am func";
    }
    // 函数修改器
    modifier M(){
        _;
    }
    // 事件
    event Log(uint l1,address ad);
    // 错误
    error myError();
    // 结构体
    struct People{
        string name;
        uint age;
    }
    // 枚举类型
    enum Status{
        None,
        Pendding,
        Canceled
    }
}
```

如果一个.sol文件中，有多个合约，那么在部署的时候需要注意切换到对应的合约

编译的时候会一起编译，但是在部署的时候要选择对应的合约类型

![image-20220705090122480](/Users/yunphant/Desktop/%E5%AD%A6%E8%80%8C%E5%AE%9E%E4%B9%A0%E6%97%B6/%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6/image-20220705090122480.png)

### 1.5注释

solidity有两种注释方式，单行注释和多行注释

`notes.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract notes{
    // 单行注释
    /*
        多行注释
        多行注释
    */
}
```

## 2、简单数据类型

官方文档中的分类是按照值类型和引用类型进行划分，Solidity的值传递和引用传递有自己的规则，通过不同的存储域决定，后面会详细介绍，本节中会先介绍一些常见的数据类型，其他复杂的数据类型会每一章单独介绍

Solidity中不存在`undefined`或`null`，每种变量都有自己的默认值，一般是“零状态”

### 2.1修饰符

solidity支持对变量进行修饰，`public`和`private`，0.8版本默认的是private(后面会学到`public`和`private`也可以对函数进行修饰)，用`public`和`private`对类型变量的区别就是合约外部能不能访问



```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
contract type1{
    string  str1 = "i am default";
    string public str2 = "i am public";
    string  private str3 = "i am default";
}
```

### 2.2布尔类型

bool:常量值为true和false

默认值为flase

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract type2{
   bool public b1;
   bool public b2 =true; 
}

```

### 2.3整型

#### 2.3.1有符号整型和无符号整型

int / uint ：分别表示有符号和无符号的不同位数的整型变量，支持关键字 uint8到 uint256 （无符号，从 8 位到 256 位）以及 int8 到 int256，以 8 位为步长递增，uint 和 int 分别是 uint256 和 int256的别名，也就是默认int和uint都是256位

利用内置的type函数可以查看uint和int的最大最小值

`type(类型).max` `type(类型).mim`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

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
```

#### 2.3.2运算符号

##### 加减乘

和平常的理解意义是一样的，注意溢出情况的，在0.8.0版本以后会自动检查溢出的情况，如果不想检查溢出的情况，那么利用`unchecked{}`来取消检查。在此之前需要使用`OpenZepplin SafeMath`

```go
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

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
```

##### 除法

整数除法总是产生整数，在Solidity中，分数会取零，如果在运算的过程中，出现这样的截断舍入，那么可以通过中间放大，结果还原的方式

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

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
```

除以0 会发生 Panic 错误， 而且这个检查，不可以通过 `unchecked {}` 禁用掉

还可以设置通过规定小数点的位数解决小数截断的问题，比如规定后面6位是小数

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract type5{
    // 规定后六位是小数
    uint i1 = 1000000;
    function mycal(uint _param)external view returns(uint){
        return i1/_param;
    }
    // 1000000/4 = 250000  后六位是小数  按规定250000则为0.25
}
```

##### 模运算

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract type6{
    uint i1 = 5;
    uint i2 = 2;
    uint public i3 = i1%i2;
}
```

##### 幂运算

幂运算仅适用于无符号类型，结果的类型总是等于基数的类型，请注意类型足够大以能够容纳幂运算的结果，要么发生潜在的assert异常或者使用截断模式

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract type7{
    uint public a= 10**18;
    //uint public a= 10**256; 溢出
}
```

##### 移位运算

移位操作的结果具有左操作数的类型，同时会截断结果以匹配类型。 右操作数必须是无符号类型。 尝试按带符号的类型移动将产生编译错误

移位可以通过用2的幂的乘法来实现，请注意，左操作数的截断总是在最后发生，但是不会明确提醒

`x << y` 等于数学表达式 `x * 2 ** y`

`x >> y` 等于数学表达式 `x / 2 ** y` 

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

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
```

##### 其他运算

比较运算符： `<=` ， `<` ， `==` ， `!=` ， `>=` ， `>` （返回布尔值）

这些比较运算符用的比较多，作用也比较好理解

位运算符： `&` ， `|` ， `^` （异或）， `~` （位取反）

这些运算符号用的相对比较少，都是位运算，建议大家私下都敲一敲熟悉一下，当做对运算符熟悉的作业，这里就不展开了

### 2.3地址类型

这是比较特殊的类似，其他语言没有，实际上是储存字节

地址类型有两种：

​		address:保存一个20字节的值（以太坊地址的大小），不支持作为转账地址

​        address payable：可参与转账的地址，与 address 相同，不过有成员函数 `transfer` 和 `send`	

区别就是在合约的控制中，这个payable类型的是可以发送和接受以太币的,如果你需要 `address` 类型的变量，并计划发送以太币给这个地址，那么声明类型为 address payable可以明确表达出你的需求。 同样，尽量更早对他们进行区分或转换

address 和 address payable的区别是在 0.5.0 版本引入的

允许从address payable 到 address 的隐式转换，而从 address到 address payable 必须显示的转换, 通过 payable(address)进行转换

address 允许和 uint160、 整型字面常量、bytes20及合约类型相互转换，也就是说地址就是40位16进制数最后呈现在我们面前

address.balance返回 uint256，以 Wei 为单位的余额

address.code返回bytes memory地址上的字节码(可以为空)，获取EVM的字节码

address.codehash (bytes32)，地址上的字节码哈希，也就是对keccak256(address.code)得到的结果

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  
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
```

address payable.transfer(uint256 amount)向该地址发送数量为 amount 的 Wei，失败时抛出异常，并且会回滚，使用固定（不可调节）的 2300 gas 的矿工费

address payable.send(uint256 amount) returns (bool)向该地址发送数量为 amount 的 Wei，失败时返回 false，发送 2300 gas 的矿工费用，不可调节，编译器也会提示，尽量使用transfer，因为执行报错了的话，transfer会回退主币，但是send出错了的话，不会回退主币

注意转账的时候注意，调用transfer的话，钱是从合约中转出去的，所以要合约中有主币才行，然后注意调用transfer的地址是接受者

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
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
```

`call` `delegatecall` 和 `staticcall`

这三个地址成员变量涉及到合约的调用，如何使用后面会进行详细的介绍

### 2.4枚举类型

枚举类型至少需要一个成员，且不能多于256个成员。整数类型和枚举类型只能显式转化，不能隐式转化。整数转枚举时需要在枚举值的范围内，枚举就是整型的互换

使用 `type(NameOfEnum).min` 和 `type(NameOfEnum).max` 你可以得到给定枚举的最小值和最大值

```solidity
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
```

### 2.5自定义类型

一个用户定义的值类型允许在一个基本的值类型上创建一个零成本的抽象。 这类似于一个别名，但有更严格的类型要求

用户定义值类型使用 type C is V来定义，其中C是新引入的类型的名称，V必须是内置的值类型（”底层类型”）， 函数 `C.wrap`被用来从底层类型转换到自定义类型，同样地，函数函数 `C.unwrap` 用于从自定义类型转换到底层类型

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
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
```

### 2.6常量

常量可以节约gas，constant定义的一半全大写， 

加上immutable也是常量了，constant必须在定义的时候就赋值，immutable修饰的话 那么可以在部署的时候传入 就是在构造函数中去赋值

constant的编译前就需要赋值，immutable可以后期赋值，但是也只能进行一次赋值

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
// 21371 gas
contract Constant{
    uint public constant A =1;
}
// 23471 gas 
contract NotConstant{
    uint public A = 1;
}
// 确实读取常量变量的gas会更加节约
contract Imu{
    address public immutable owner = msg.sender;   
}
```

## 3、字面常量

字面量常量主要是去了解各个类型的数据的样子

### 3.1地址字面常量

只有经过校验后的地址字面量才能作为address变量

原来包含大写字母的是经过了校验和(checksum)的地址，这个校验和有什么作用呢？因为以太坊地址本身不包含校验信息，一旦用户输入错误，没有一种机制校验，该交易将会永远丢失，那么现在就是用EIP-55的标准解决这个问题

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test1{
    //address public addr1 = 0x7cb57b5a97eabe94205c07890be4c1ad31e486a8;//该地址没有通过校验和（checksum），会报错
    address public addr1 = 0x7cB57B5A97eAbe94205C07890BE4c1aD31E486A8;
    address public addr2 =address(0);
    //address public addr3 = 0x1111111111111111111A11111111111111111111;  无法通过校验的值就不能进行赋值
}
```

### 3.2有理数和整数的字面常量

可以添加下划线，提高可读性，但是只能在数字和数字之间添加，下划线不允许连续出现

支持科学计数法

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test2{
    uint public a = 123_000;  //123000
    //uint public b = 123__000;连续下划线出错
    uint public b = 123_0_00;
    uint public c = 2e10;
    //uint public d = 2_e10;  数字字母之间不能添加下划线
}
```

### 3.3字符串字面常量及类型

字符串"foo"相当于3个字节，而不是4个字节，它不像C语言里以`\0`结尾。

字符串字面常量可以隐式的转换成bytes1,...bytes32，在合适的情况下，可以转换成bytes以及string

字符串字面常量只包含可打印的ASCII字符和下面的转义字符：

`\<newline>` (转义实际换行)

`\\` (反斜杠)

`\'` (单引号)

`\"` (双引号)

`\b` (退格)

`\f` (换页)

`\n` (换行符)

`\r` (回车)

`\t` (标签 tab)

`\v` (垂直标签)

`\xNN` (十六进制转义，表示一个十六进制的值，)

`\uNNNN` (unicode 转义，转换成UTF-8的序列)

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test3{
    string public str1 = "foo";
    //string public str1 = "foo"+"aa";//加号拼接是不行的
    bytes1 public by1 = "s";
    string public str2 = "foo\n";
    string public str3 = "foo\x0001";
}
```

### 3.4十六进制的字面常量

十六进制字面常量以关键字 `hex` 打头，后面紧跟着用单引号或双引号引起来的字符串（例如，`hex"001122FF"` ）, 字符串的内容必须是一个十六进制的字符串，作用可以用来拼接成带有0x的十六进制字符串

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test4{
    bytes public a = hex"0111";
}
```

### 3.5Unicode 字面常量

常规字符串文字只能包含ASCII，而Unicode文字（以关键字unicode为前缀）可以包含任何有效的UTF-8序列，它们还支持与转义序列完全相同的字符作为常规字符串文字，这样的话就可支持中文了

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test5{
    // string public str1 = "智能合约"; 不能赋值中文
    string public str2 = unicode"智能合约";
}
```

## 4、类型转化

### 4.1基本类型转化

#### 4.1.1隐式转化

在某些情况下，编译器会自动进行隐式类型转换， 这些情况包括: 在赋值, 参数传递给函数以及应用运算符时， 通常，如果可以进行值类型之间的隐式转换， 并且不会丢失任何信息 ，都是可以隐式类型转换

例如uint8可以转换成uint16，int128转换成int256，但int8不能转换成uint256

隐式转化就是编译器航我们干了，但是如果要进程隐式转化的，要确保的问题两个类型之间是否可进行隐式转化，基本上原则就是从小往大转

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract type18{
    uint8 public a = 100;
    uint16 public b = a;//不会溢出 没问题
    uint16 public c= 10;
    //uint8  public d = c;//TypeError: Type uint16 is not implicitly convertible to expected type uint8.
}
```

#### 4.1.2显示转化

如果编译器不允许隐式转换，而你足够自信没问题，那么就去尝试显示转换，但是这很容易造成安全问题

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
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
```

### 4.2地址类型转化

address payable可以完成到 address的隐式转换，但是从address到address payable必须显式的转换, 通过 payable(address)进行转换

实际上，合约类型、uint160、整数字面常量、bytes20都可以与address类型互相转换

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract test3{
   address public addr1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
   address payable public addr2 = payable(addr1);//address 强制转化成address payable
   uint160 public addr3 = uint160(addr1);
   uint160 public addr4 = uint160(address(addr2));//address payable 就不行
   bytes20 public addr6 = bytes20(addr1);
}
```

### 4.3字面常量和基本类型的转化

十进制和十六进制字面常量可以隐式转换为任何足以表示它而不会截断的整数类型

字面常量和基本类型的转化就是将字面常量赋值给基本数据类型变量，所以重要的一点就是注意在赋值或者转化的时候注意范围和类型的要求，这里就不在过多的叙述

## 5、数据的存储位置

数据位置不仅仅表示数据如何保存，它同样影响着赋值行为，那数据的位置的划分就是数据是否需要存在链上，一般称需要存储上链的数据为状态变量，其他在函数内的为内存变量

在官方教程中，还有一个数据的赋值行为

memory:存储在内存里，只在函数内部使用，函数内变量不做特殊说明为memory类型

storage:相当于全局变量，函数外合约内的都是storage类型

calldata:保存函数的参数的特殊储存位置，只读，大多数时候和memory相似

其实就是用memory和calldata是属于值传递，storages属于引用传递，这三个修饰符是在定义函数参数是需要显示标注的

如果在函数的输出参数中采用了数组类型（string和bytes也算数组），那么就必须要使用memory或者calldata

内部函数之间有调用的时候使用calldata传递函数参数的话也是节省gas，好像如果使用memory会复制一份参数，而calldata直接传递

calldata比memory节省gas，如果某个都是被调用，然后传入参数执行，那么可以定义参数的格式为calldata

`dataPosition`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract dataPosition{
    uint[] public a;

    function pushOne()public {
        uint[] storage _a = a; //storage定义的变量属于引用传递，修改该变量会导致源数据修改
        _a.push(1);
        uint[] memory _b = new uint[](5);//memory定义的变量属于值传递 修改该变量不会导致源数据修改
        _b=_a;
        _b[0] = 100; 
    }

    function example(string calldata)external pure returns(string memory,string memory){
        return("i am example","i am example too");
    }
}
```



# 第三章：内置单位和函数

## 1、单位

### 1.1币

币的单位默认是`wei`，也可以添加单位，也就是在智能合约中使用币的时候1就代表了1wei

其他单位有`gwei`、`ether`

换算关系为

```
1 gwei =1e9 wei
1 ether = 1e18 wei 
```

注意:之前还有其他的单位`finney`和`szabo`从0.7.0被移除了

`innerCompany.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract Company{
    function moneyTest()external pure{
       assert(1 wei == 1);
       assert(1 gwei == 1e9);
       assert(1 ether == 1e18); 
    }
}
```

### 1.2时间

秒是缺省时间单位，在时间单位之间，数字后面带有 `seconds`、 `minutes`、 `hours`、 `days` 和 `weeks` 的可以进行换算，基本换算关系如下：

 ```
 1 == 1 seconds
 1 minutes == 60 seconds
 1 hours == 60 minutes
 1 days == 24 hours
 1 weeks == 7 days
 ```

注意：`years` 已经在 0.5.0 版本去除了，因为闰年的原因

## 2、特殊变量和函数

### 2.1区块和交易属性

有很多内置的常用函数，注意用法和含义，而且下面介绍都是最新的用法，括号里面是返回值的类型

`blockhash(uint blockNumber) returns (bytes32)`：指定区块的区块哈希 —— 仅可用于最新的 256 个区块且不包括当前区块，否则返回 0 

`block.basefee(uint)`: 当前区块的基础费用，

`block.chainid(uint)`: 当前链 id

`block.coinbase(address)`: 挖出当前区块的矿工地址

`block.difficulty(uint)`: 当前区块难度

`block.gaslimit(uint)`: 当前区块 gas 限额

`block.number(uint)`: 当前区块号

`block.timestamp(uint)`: 自 unix epoch 起始当前区块以秒计的时间戳

`gasleft() returns(uint256)` ：剩余的 gas

`msg.data(bytes)`: 完整的 calldata

`msg.sender(address)`: 消息发送者（当前调用）

`msg.sig(bytes4)`: calldata 的前 4 字节（也就是函数标识符）

`msg.value(uint)`: 随消息发送的 wei 的数量

`tx.gasprice(uint)`: 交易的 gas 价格

`tx.origin(address)`: 交易发起者（完全的调用链）

这些内置函数在后面的教程中还会频繁的时候，这里先了解一下对应的格式可以了

注意几大变化：

`gasleft`原来是`msg.gas`

`block.timestamp`原来是`now`

`blockhash`原来是`block.blockhash`

`innerFunc.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract innerFunc{
    // 区块相关
    uint public blocknumber=block.number; //区块号
    uint public blocktimestamp=block.timestamp;//区块生成的时间
    uint public blockgaglimt = block.gaslimit;//当前区块的gas限制
    uint public blockdifficulty = block.difficulty;//当前区块难度
    address public blockcoinbase = block.coinbase;//当前区块的旷工地址
    uint public chainID = block.chainid;//当前链的ID

    //合约调用相关
    bytes public msgbytes = msg.data;//完整的calldata
    address public msgsender = msg.sender;//合约调用者
    bytes4 public funcname = msg.sig;//calldata 的前 4 字节（也就是函数标识符）
    uint public msgvalue = msg.value;//调用合约的时候携带的主币数量

    //交易相关
    uint public txgasprice=tx.gasprice;//交易的当前gas
    address public txorigin =tx.origin;
}
```

### 2.3delete

`delete a`不是常规意义上的删除，而是给`a`赋默认值（即返回不带参数的声明的状态），比如`a`是整数，那么等同于`a=0`。对用动态数组是将数组长度变为0；对于静态数组是将每一个元素初始化；对于结构体就把每一个成员初始化；对于映射在原理上无效（不会影响映射关系），但是会删除其他的成员，如

`delete.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract DeleteExample {
    uint public data = 1;
   uint[] public arrydata =[1,2];

    function deldata()external {
        delete data;
    }
    // 不影响数组长度 删除的元素置为默认值
    function delarrydata0()external {
        delete arrydata[0];
    }
    //直接删除数组的话  会导致数组的长度变成0
    function delarrydata()external {
        delete arrydata;
    }
}
```

## 3、ABI编码及解码函数

什么是ABI呢，目前可以理解成ABI是智能合约交互的接口，规定与合约交互方式的规则，ABI规则在其他的章节会做重点的介绍，现在只需要把ABI当做以太坊内部提供的一个接口，同时下面所介绍的ABI接口的用法在智能合约中也是有固定的用法，所以不用太担心不懂，可以先了解怎么使用，后面的章节会进一步的介绍ABI的规则

接下来我们就来了解一下ABI编码和解码函数的使用

`encode`和`decode`

对于给定的参数进行编码，对已经经过ABI编码的数据进行解码

`abi.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testABI{
    // 获得编码以后的数据  按照ABI的编码规则
    bytes public c = abi.encode(5,1);
    
    uint public d;
    int public e;
    constructor(){
        (d,e) = abi.decode(c,(uint,int));
    }
}
```

`encodePacked()`

一种abi打包模式，对给定参数执行紧打包编码（即编码时不够 32 字节，不用补0了）

`abi.sol`

```go
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testABI2{
    //打包以后的数据  没有补0
    bytes public c = abi.encodePacked("5","1");

}
```

`encodeWithSelector(bytes4 selector, ...）` 

 对函数选择器和传入的参数一起打包返回，打包的规则这里就不展开，暂时会用就够了

`abi.encodeWithSignature(string signature, ...)`等价于 `abi.encodeWithSelector(bytes4(keccak256(signature), ...)`

`abi.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testABI3{
    uint public a;

    function add(uint b,uint c) public returns (uint) {
        a=a+b+c;
        return a;
    }

    // 下面两种写法的效果是一致的
    //bytes public encodedABI=abi.encodeWithSelector(this.add.selector,5,1);
    bytes public encodedABI = abi.encodeWithSignature("add(uint256,uint256)",5,1);

    function callFunc()public returns(bool,bytes memory,uint) {
        bool flag=false;
        bytes memory result;
       (flag,result) = address(this).call(encodedABI);
       return (flag,result,a);
    }
   
}
```

其实ABI就是一种特殊的接口，然后智能合约中也规范了一些ABI的编码规则，我们通过ABI接口调用智能合约的时候，需要按这样编码规则来传入数据，而且生成的那个json的abi，其实他就是对合约的一个描述，描述合约的方法的名称和输入输出的情况，能确保调用无误

## 4、哈希算法

关于加密算法的知识，还需要等待补充

`keccak256`、`sha256`、`ripemd16`

`hash.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testHash{
    uint public a;
    function add(uint b) public {
        a+=b;
}
    
    // 下面两种写法是效果是一样的  是ABI编码规则中函数名编码的前四个字节
    bytes4 public selector = this.add.selector;
    bytes4 public genSelector = bytes4(keccak256("add(uint256)"));
    bool public isequal = (selector==genSelector);
    
    bytes32 public sha = sha256("add(uint256)");
    bytes32 public ripemd = ripemd160("add(uint256)");
}
```



`ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) returns (address)`

利用椭圆曲线签名恢复与公钥相关的地址，错误返回零值。

函数参数对应于 ECDSA签名的值:

​	`r` = 签名的前 32 字节

​	`s` = 签名的第2个32 字节

​	`v` = 签名的最后一个字节

`ecrecover` 返回一个 `address`, 而不是 `address payable` ，他们之前的转换参考address payable ，如果需要转移资金到恢复的地址

## 5、地址成员

一个地址类型的对象，含有很多内置方法，下面一个一个来介绍一下

`<address>.balance` (`uint256`)

获取地址的余额，注意啊，这只是获取主币的余额，如果要获取某个ERC20代币的余额，那么只能通过ERC20合约里面定义获取余额去查询

`<address>.code` (`bytes memory`)

这个是啥

`<address>.codehash` (`bytes32`)

这个是啥



`<address payable>.transfer(uint256 amount)`

像地址发送主币，钱是从合约地址走，转给该地址

`<address payable>.send(uint256 amount) returns (bool)`

转账的低级版本

使用 `send` 有很多危险：如果调用栈深度已经达到 1024（这总是可以由调用者所强制指定），转账会失败；并且如果接收者用光了 gas，转账同样会失败。为了保证以太币转账安全，总是检查 `send` 的返回值，利用 `transfer` 或者下面更好的方式： 用这种接收者取回钱的模式





合约调用

`<address>.call(bytes memory) returns (bool, bytes memory)`

用给定的有效载荷（payload）发出低级 `CALL` 调用，返回成功状态及返回数据，发送所有可用 gas，也可以调节 gas。

在执行另一个合约函数时，应该尽可能避免使用 `.call()` ，因为它绕过了类型检查，函数存在检查和参数打包







`<address>.delegatecall(bytes memory) returns (bool, bytes memory)`

用给定的有效载荷 发出低级 `DELEGATECALL` 调用 ，返回成功状态并返回数据，发送所有可用 gas，也可以调节 gas。 发出低级函数 `DELEGATECALL`，失败时返回 `false`，发送所有可用 gas，可调节

如果在通过低级函数 delegatecall 发起调用时需要访问存储中的变量，那么这两个合约的存储布局需要一致，以便被调用的合约代码可以正确地通过变量名访问合约的存储变量。 这不是指在库函数调用（高级的调用方式）时所传递的存储变量指针需要满足那样情况。



`<address>.staticcall(bytes memory) returns (bool, bytes memory)`

用给定的有效载荷 发出低级 `STATICCALL` 调用 ，返回成功状态并返回数据，发送所有可用 gas，也可以调节 gas。



由于 EVM 会把对一个不存在的合约的调用作为是成功的。 Solidity 会在执行外部调用时使用 extcodesize 操作码进行额外检查。 这确保了即将被调用的合约要么实际存在（它包含代码）或者触发一个异常

对地址而不是合约实例进行操作的低级调用(如 `.call()` , `.delegatecall()` , `.staticcall()` , `.send()` 和 `.transfer()` ) 时， **不** 包括这个检查，这使得它们在GAS方面更便宜，但也更不安全



这一块的知识确实得等了解了更多  往后放放



# 第四章：智能合约与控制结构

通过前面三章的学习，我们对solidity的基础知识也有了一定的了解，接下来开始进一步学习合约

前面说了其实智能合约就是一个代码脚本，在solidity中智能合约的基本单位是合约，也就是`contract`,一个完整的solidity程序就是有0~N个`contract`构成，其实我们完全可以把合约当类，合约里面的状态变量和函数就是成员变量和成员方法，这样理解是完全可以的

## 1、控制结构

Solidity 支持 `if`, `else`, `while`, `do`, `for`, `break`, `continue`, `return`这些和C语言一样的关键字

Solidity还支持 `try`/`catch` 语句形式的异常处理， 但仅用于外部函数调用和合约创建调用，关于`try`/`catch` 的使用后面在报错机制会详细的介绍

由于不支持非布尔类型值转换成布尔类型，因此`if(1){}`是不合法的

关于简单的控制结构的语法，这里就不展开详细的叙述了

## 2、合约类型

前面提过完全可以把合约当做一个类，利用`contract`修饰的我们就可以把它当做一个合约类型，那可以像java那样创建类的实例么，答案是可以的，我们可以通过合约类型创建合约实例，通过`new`关键字或者`create2`的方式，其实就是部署了一个新合约，注意，这样的调用是产生了一个新的合约

如果想要使用某个合约的功能代码，其中一种方式就是在合约中通过创建一个合约实例来调用，注意这样方式是创建新合约，并不是调用已经部署的合约，不过这种方式需要已知一个合约完整的代码的前提下（写在同一个文件内）

### 2.1通过new关键字创建合约

下面会用callContract在合约内部创建一个testContract，同时传入主币和参数，这个时候其实是部署了一个新的testContract合约，我们继续改变合约的状态变量，接下来去看下通过callContract部署的合约是否数据是正常的

`newContract.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract testContract{
    uint public a;
    constructor(uint _a) payable{
        a=_a;
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
    
    function getContractName()external pure returns(string memory){
        return "testContract";
    }
    function setA(uint _a)external{
        a = _a;
    }
}
contract callContract{
    // 创建了一个合约 注意还没遇实例化，这个时候调用会出错
    testContract t;
    address public contractaddr;//合约地址
    string public contractName;//合约名字 
     // type(合约类型)   可以获取合约的相关的参数
    string public str1;
    bytes public by;
    function createContractObj(uint amount)public payable{
        t = new testContract{value:amount}(5);
       
    }
     function initParams()external {
        contractaddr =address(t); 
        contractName = t.getContractName();
        str1 = type(testContract).name;
        by = type(testContract).creationCode;
    }
    function setA(uint _a)external {
        t.setA(_a);
    }
    function getA()external view returns(uint){
        return t.a(); //通过public生成的getter方法读取状态变量
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
```

注意一个情况，就是定义合约对象以后，如果不用`new`关键字去实例化的话，是不能调用合约对象的

合约类型可以显式转换为address类型，就能获取到新部署的合约地址

合约类型的成员是合约的外部函数及public的状态变量，合约变量是无法访问私有的内容

对于合约C可以使用type(C)获取合约的类型信息，可以获取合约c的名称和creationCode



同时通过new关键字部署一个新合约的时候可以传入主币，注意无法限定gas，这里可以发现，如果在调用下面合约中`createContractObj`传入了多余的主币，那么多余的主币会存在当前合约

`newContractWithMoney.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract testContract{
    // 可接受主币
    receive() external payable{}
    uint public a;

    constructor(uint _a) payable{
        a=_a;
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
contract callContract{
    // 创建了一个合约 注意还没遇实例化，这个时候调用会出错
    testContract t;
    address public contractaddr; 
    function createContractObj(uint amount)public payable{
        t = new testContract{value:amount}(5);
        contractaddr =address(t); 
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
```

### 2.2通过create2创建合约

这种方式在合约中创建合约，合约地址是可以计算出来的，合约的地址时由创建时交易的nonce和创建者的地址决定，但是还可以选择一个32个字节的`salt` 来改变生成合约地址的方式，合约地址将会由创建者的地址、给定`salt`、被创建合约的字节码及参数共同决定。下面是计算方法

`create2.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

 contract D{
     uint public arg;
     constructor(uint _arg){
         arg = _arg;
     }
 }

contract Create2{
     D public d;
    function getBytes32(uint slat)external pure returns(bytes32){
        return bytes32(slat);
    }
    //这里是计算合约地址的方法
    function getAddress(uint slat,uint arg) external view returns(address){
        address add = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            slat,
            keccak256(abi.encodePacked(
                type(D).creationCode,
                arg
            ))
        )))));
        return add;
    }

    function createDSalted(bytes32 salt,uint arg)public{
        d = new D{salt: salt}(arg);
    }
}
```

这一特性使得在销毁合约之后在重新在同一地址生成代码相同的合约



下面是一个通过一个工厂合约部署的例子，大家可以实现下

`newContractFactory.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract Car {
    address public owner;
    string public model;
    constructor(address _owner, string memory _model) payable {
        owner = _owner;
        model = _model;
    }
}
contract CarFactory {
    Car[] public cars;
    function create(address _owner, string memory _model) public {
        Car car = new Car(_owner, _model);
        cars.push(car);
    }
    
    function createAndSendEther(address _owner, string memory _model)public payable{
        Car car = (new Car){value: msg.value}(_owner, _model);
        cars.push(car);
    }

    function getCar(uint _index)public view returns (address owner, string memory model, uint balance){
        Car car = cars[_index];
        return (car.owner(), car.model(), address(car).balance);
    }
}
```

## 3、赋值、作用域声明和算术检查

### 3.1赋值

Solidity 内部允许元组 (tuple) 类型，也就是一个在编译时元素数量固定的对象列表，列表中的元素可以是不同类型的对象。这些元组可以用来同时返回多个数值，也可以用它们来同时给多个新声明的变量或者既存的变量

`assignment.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testAssignment{
    uint index;

    function f() public pure returns (uint, bool, uint) {
        return (7, true, 2);
    }

    function g() public {
        //基于返回的元组来声明变量并赋值
        (uint x, bool b, uint y) = f();
        //交换两个值的通用窍门——但不适用于非值类型的存储 (storage) 变量。
        (x, y) = (y, x);
        //元组的末尾元素可以省略（这也适用于变量声明）。
        (index,,) = f(); // 设置 index 为 7
    }
}
```

赋值语义对于像数组和结构体(包括 `bytes` 和 `string`) 这样的非值类型会涉及到值传递和引用传递的区别

值传递就是在赋值的是把值拷贝给赋值对象，赋值对象的修改并不会影响源数据

引用传递就可以通过修改赋值对象的值，同时修改源数据

`complexAssignment.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testAssignment{
    uint[20] public x;
     function f() public {
        g(x);
        h(x);
    }

     function g(uint[20] memory y) internal pure {
        y[2] = 3;
    }

     function h(uint[20] storage y) internal {
        y[3] = 4;
    }
}
```

### 3.2作用域声明

变量声明后将有默认初始值，其初始值字节表示全部为零。任何类型变量的“默认值”是其对应类型的典型“零状态”。例如， `bool` 类型的默认值是 `false` 。 `uint` 或 `int` 类型的默认值是 `0` 。对于静态大小的数组和 `bytes1` 到 `bytes32` ，每个单独的元素将被初始化为与其类型相对应的默认值。 最后，对于动态大小的数组 `bytes` 和 `string` 类型，其默认缺省值是一个空数组或空字符串。

对于 `enum` 类型, 默认值是第一个成员。

Solidity 中的作用域规则遵循了 C99（与其他很多语言一样）：变量将会从它们被声明之后可见，直到一对 `{ }` 块的结束。作为一个例外，在 for 循环语句中初始化的变量，其可见性仅维持到 for 循环的结束。

对于参数形式的变量（例如：函数参数、修饰器参数、catch参数等等）在其后接着的代码块内有效。 这些代码块是函数的实现，catch 语句块等。

那些定义在代码块之外的变量，比如函数、合约、自定义类型等等，并不会影响它们的作用域特性。这意味着你可以在实际声明状态变量的语句之前就使用它们，并且递归地调用函数。



最后一轮出案例



### 3.3算术检查

当对无限制整数执行算术运算，其结果超出结果类型的范围，这是就发生了上溢出或下溢出。

在Solidity 0.8.0之前，算术运算总是会在发生溢出的情况下进行“截断”，从而得靠引入额外检查库来解决这个问题（如 OpenZepplin 的 SafeMath）。

而从Solidity 0.8.0开始，所有的算术运算默认就会进行溢出检查，额外引入库将不再必要。

如果想要之前“截断”的效果，可以使用 `unchecked` 代码块

其实也就是在0.8.0开始不在需要在运算完以后检查溢出，会自动进行检查，如果不想让让编译器检查的话可以使用`uncheck`

`uncheck.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testUncheck{
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
```

## 4、错误处理及异常

Solidity 使用状态恢复异常来处理错误。这种异常将撤消对当前调用（及其所有子调用）中的状态所做的所有更改，并且还向调用者标记错误，底层函数错误是不会回滚的，而是返回 false 和 error instance

注意：根据 EVM 的设计，如果被调用的地址不存在，低级别函数 `call`, `delegatecall` 和 `staticcall` 也或第一个返回值同样是 true， 如果需要，请在调用之前检查账号的存在性

异常可以包含错误数据，以 error的形式传回给调用者。 内置的错误 `Error(string)` 和 `Panic(uint256)` 被作为特殊函数使用，下面将解释， `Error` 用于 “常规” 错误条件，而 `Panic` 用于在（无bug）代码中不应该出现的错误

### 4.1报错机制

目前在智能合约中产生报错的形式有4种，`require` `assert` `revert` `error`

在实际的应用中require使用的比较多，不满足条件同时也会输出提示信息

assert和revert的区别在于是否需要if判断协助，这两种都不会有提示信息的输出

自定义错误可以返回错误的参数信息，比较的灵活

`handleError.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity 0.8;

// require revert assert
// 自定义错误  节省gas
contract error{

    function testRequire(uint i)external pure{
        require(i<10,"i>10");//i>10时  就是条件不满足时触发
    }

    function testRevert(uint i)external pure{
        if(i>10){
            revert("i>10");
        }
    }
    function testAssert(uint i)external pure{
        assert(i>10);//判断为false时会报错
    }
    // 下面看看gas   和状态的回滚
    uint public num =1;
    function foo(uint i)external{
        num+=1;
        require(i>10,"i<10back");
    }

    // 下面使用自定义错误  节约gas
    // 是通过revert触发的
    error myError(address caller,uint i);
    function testMyError(uint i)external view{
        if(i>10){
            revert myError(msg.sender,i);
        }
    }
}
```

### 4.2try/catch

**`try`后面只能接外部函数调用或者是创建合约`new ContractName`的表达式**

catch的部分分成3块

​		revert和require类型的报错会被Error捕获

​		异常和assert会被Pannic捕获

​		自定义的错误及无返回提示的底层错误会走到最后

`ty.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity 0.8;

//
contract DataFeed { 
    // function add(uint a,uint b) external pure returns (uint value){
    //     return a/b;
    // }
    error myError();
    function add(uint a,uint b) external pure returns (uint value){
        // revert("1");
        return a/b;
    }
    
}
contract FeedConsumer {
    DataFeed feed = new DataFeed();//从接口创建合约
    uint public errorCount;//记录错误次数
    function testAdd() public returns (uint _value, bool _success) {
        try feed.add(5,0) returns (uint v) {//尝试调用 外部的 getData 函数，执行成功就获得返回值，然后继续执行花括号内的内容
            return (v, true);
        } catch Error(string memory /*reason*/) {
            // 通过revert发起的错误
            errorCount = 2;
            return (100, false);
        } catch Panic(uint /*errorCode*/) {
            // 异常类型的错误会走到这里
            errorCount = 1;
            return (200, false);
        } catch (bytes memory /*lowLevelData*/) {
            // 无返回提示的底层错误，自定义错误的话会走到这里
            errorCount=8;
            return (300, false);
        }
    }
   
}
```

智能合约中使用try/catch的设计目前使用不多，后面如果在项目中找到更好的使用案例的话，到时候再补充这里

# 第五章：函数

## 1、函数的结构

在智能合约中，函数可以创建在合约的内部，也可以创建合约的外部

需要大量复用的函数就可以定义在合约的外部，可以类似当做工具类使用，定义在合约外的函数叫做自由函数，一定是`internal`类型，就像一个内部函数库一样，会包含在所有调用他们的合约内，就像写在对应位置一样。但是自由函数不能直接访问全局变量和其他不在作用域下的函数（比如，需要通过地址引入合约，再使用合约内的函数）

`innerFunc.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8; 

function sum(uint[] memory _arr) pure returns (uint s) {
    for (uint i = 0; i < _arr.length; i++)
        s += _arr[i];
}
contract ArrayExample {
    bool found;
    function f(uint[] memory _arr) public {
        uint s = sum(_arr);
        require(s >= 10);
        found = true;
    }
}
```

函数的结构主要由函数名+可见性+返回值构成

​											function 函数名(参数) ` 可见性` `其他修饰`  `函数修饰器` returns(返回值){函数体}

上面就是智能合约中函数的结构，其实相对陌生的就是`可见性` `函数修饰器`，下面我们就按照函数的结构来一步步分析智能合约的函数

## 2、可见性和函数状态可变性

### 2.1可见性

#### 2.1.1状态变量可见性

状态变量有 3 种可见性：

`public`

对于 public 状态变量会自动生成一个 getter函数， 以便其他的合约读取他们的值。 当在用一个合约里使用是，外部方式访问 (如: this.x) 会调用getter 函数， Setter函数则不会被生成，所以其他合约不能直接修改其值

`internal`

内部可见性状态变量只能在它们所定义的合约和派生合同中访问，它们不能被外部访问，这是状态变量的默认可见性

`private`

私有状态变量就像内部变量一样，但它们在派生合约中是不可见的

`vaiableVisibility.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract TestVV{
    uint public a = 1;
    uint internal b = 2;
    uint private c = 3;
    function getA()external view returns(uint){
        return a;
    }
}
```

**注意：**区块链所有信息都是透明的，这里的可见性只是针对其他合约或者调用者的是否有权限，访问或者修改状态。

#### 2.1.2函数可见性

由于 Solidity 有两种函数调用：外部调用则会产生一个 EVM 调用，而内部调用不会， 更进一步， 函数可以确定器被内部及派生合约的可访问性，这里有 4 种可见性：

`external`

外部可见性函数作为合约接口的一部分，意味着我们可以从其他合约和交易中调用。 一个外部函数 f 不能从内部调用（即 f 不起作用，但 this.f() 可以）

`public`

public 函数是合约接口的一部分，可以在内部或通过消息调用。

`internal`

内部可见性函数访问可以在当前合约或派生的合约访问，不可以外部访问。 由于它们没有通过合约的ABI向外部公开，它们可以接受内部可见性类型的参数：比如映射或存储引用

`private`

private 函数和状态变量仅在当前定义它们的合约中使用，并且不能被派生合约使用

该可见性还是相遇合约来说的，同时理解internal和private对函数进行修饰时，区别的也就是是否能在子合约中使用

`funcVisibility.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract TestFV{
    // 有访问接口
    function externalTest()external pure returns(string memory){
        return "i am exteral";
    }
    // 有访问接口
    function publicTest()public pure returns(string memory){
        return "i am public";
    }
    // 没有访问接口
    function internalTest()internal pure returns(string memory){
        return "i am interal";
    }
    // 没有有访问接口
    function privateTest()private pure returns(string memory){
        return "i am private";
    }
    // 可以访问外部函数
    function callexternal()public view returns(string memory){
        return this.externalTest();
    }
}
```

#### 2.1.3getter函数

编译器自动为所有 public 状态变量创建 getter 函数

getter 函数具有外部（external）可见性。如果在内部访问 getter（即没有 `this.` ），它被认为一个状态变量。 如果使用外部访问（即用 `this.` ），它被认作为一个函数

`getter.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testGetter{
    uint public data;
    function getDate() public returns (uint) {
        data = 3; // internal access
        return this.data(); // external access
    }
}
```

### 2.2状态可变性

通过区分函数是个修改状态变量、是否读取状态变量来定义函数的状态可变性

其实就是这个函数中的操作是否修改了合约内的状态变量，是否读取了函数的状态变量

如果函数中的操作修改了状态变量，那么该函数就不需要添加状态可变性，下面被认为修改状态变量的事件

1. 修改状态变量
2. 产生事件
3. 创建其它合约
4. 使用 `selfdestruct`
5. 通过调用发送以太币
6. 调用任何没有标记为 `view` 或者 `pure` 的函数
7. 使用低级调用
8. 使用包含特定操作码的内联汇编

如果函数中的操作读取的状态变量但为修改，那么用`view`修饰

如果函数中的操作未改变也未读取状态变量，那么用`pure`修饰

`variableIsChanged.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract TestVC{
    uint public a =5;

    // 改变了状态变量
    function change(uint _a)external {
        a = _a;
    }

    // 读取了状态变量
    function readV()external view returns(uint){
        return a;
    }

    // 未操作未读取状态变量
    function nothing()external pure returns(string memory){
        return "i do nothing";
    }

    // 还有其他 例如调用内部函数等操作也是被视为读取状态变量
    function other()external {
        address addr = msg.sender;       
    }
}
```

## 3、不可变量和构造函数

### 3.1常量和不可变量

全局变量一般可以用常量和不可变量进行定义，并且定义赋值以后不可以再改变，在合约创建以后不可以再改变，但是constant和immutable是有区别的

只有值类型或者常量字符串 string才支持 `constant` 和 `immutable` 的标识

`constant`的值必须是全局变量，且声明时就要确定，且不可在构造函数中修改，因为它是在编译时就确定且固定的

`immutable` 既可以在全局变量声明时确定（此后不可用构造函数修改），也可以在构造函数中确定（但只能赋值一次），因为在构建时才确定并且固定的

`constant` 的常量将会把赋值给它的表达式复制到所有访问它的位置，然后再进行求值的运算，类似于 C 语言的 `#define a (7*5)`。`immutable` 的不变量则是将表达式的值复制到访问它的位置，但是占用固定的32个字节，类似于 `#define a (35)` 。因此，不可变量占用空间较多，而且实际计算表达式时会优化，`constant` 的常量可能更加省gas

`constantAndImmutable.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract ciTest{
     string constant TEXT = "abc";
    //  TEXT = ="can not change"; 会报错
     bytes32 constant MY_HASH = keccak256("abc");
     uint immutable decimals;
     uint immutable maxBalance;
     address immutable owner = msg.sender;

     constructor(uint _decimals, address _reference) {
        decimals = _decimals;
        maxBalance = _reference.balance;
     }
     function isBalanceTooHigh(address _other) public view returns (bool) {
        return _other.balance > maxBalance;
     }
}
```

### 3.2构造函数

在智能合约中有一类的特殊的函数就是构造函数，合约的构造函数至多一个，只在部署执行一次，这里有一个特别好的性质那就是只执行一次，我们可以在构造函数对合约的一些状态变量进行初始化

`constructor.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract constructorTest{
    address owner;
    constructor(address _owner){
        owner = _owner;
    }
}
```

如果在构造函数中添加了参数，那么要求再合约部署的时候需要传入构造参数

## 4、函数返回值

solidity也支持函数的多返回值，同时也支持省去不需要的返回值

`returns.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testReturn{
    // 未给返回参数取名字
    function returnMany()public pure returns(uint,bool){
        return (1,true); 
    }
    // 返回参数取了名字
    function named()public pure returns(uint x,bool b){
        return(1,true);
    }

    // 返回参数取了名字可以不用加return  但是建议加上   更加清晰
    function assigned()public pure returns(uint x,bool b){
        x=1;
        b=true;
    }
    // 通过返回值进行函数调用
    function useReturn()external pure{
        (uint _x,bool _b) = returnMany();
        (,bool _c) = returnMany();  //类似Go中的省略s

    }
}
```



## 5、函数修饰器

函数修饰器是solidity一个特殊的函数引用机制，其实就是本质还是为了降低代码的复用度提供的语法糖

还是通过代码来理解吧

`_`引用函数修饰器的函数代码执行的地方，也就是说引用函数修饰器的函数会在`_`地方执行，然后执行函数修饰器里面的代码

同时支持函数引用多层的函数修饰器，作用的顺序是从左到右,也支持像函数修饰器里面传入参数

`modifier.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Modifier{
    bool public paused;
    uint public count;


    function setP(bool _pause)external {
        paused = _pause;
    }

    // 函数修饰器 根据状态变量paused来判断是否终止程序
    modifier WhenPaused(){
        require(!paused,"already paused");
        _; 
    }

    function add()external WhenPaused{
        count++;
    }
    modifier check(uint x){
        require(x<100,"x>100");
        _;
    }
    // 多层引用 支持传参
    function addBy(uint x)external WhenPaused check(x){
        count+=x;
    }
    // 三明治写法
    modifier sandwitch(){
        count+=10;
        _;
        count = count*2;
    }
    function sandwitchTest()external  sandwitch{
        count+=1;
    }
}
```

## 6、函数的调用

在第四章的时候我们学习了在合约中创建合约对象，这样的操作其实是部署了一个新合约，通过新创建的合约对象，也是能够调用合约里面的内容，下面介绍调用一个已经存在的合约的函数

### 6.1合约调用合约

如果已经知道了想要调用的合约代码，并且知道合约部署了以后的地址，那么可以把合约导入到当前合约中，这样就可以通过下面的方式来调用合约方法了

​							`被调用合约类型`(`被调用合约的地址`).`合约方法`

`c2c.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testContract{
    uint public x;
    uint public value = 123;

    function setX(uint _x)external {
        x =_x;
    }
    function getX()external view returns(uint){
        return x;
    }
    function setXandReceiveEth(uint _x)external payable{
        x=_x;
        value = msg.value;
    }
}
contract callContract{
    function setX(address _test,uint _x)external{
        testContract(_test).setX(_x);//合约类型（合约地址）.合约方法
        // 在这个合约中，TestContract这个合约类型是我们知道的
    }

    // 第二种方法  直接吧参数变成合约类型
    // function setXx(TestContract _test,uint _x)external{
    //     _test.setX(_x);  
    // }
    function getX(address _test)external view returns(uint){
        return testContract(_test).getX();
    }
     function setXandReceiveEth(address _test,uint _x)external payable{
        testContract(_test).setXandReceiveEth{value:msg.value}(_x);//这样才能调用会接受主币的方法 把所有主币都传给调用的合约
    }
}
```

同时在调用方法的时候添加大括号可以发送主币的数量

### 6.2接口合约

当我们想要调用的合约类容不知道的话，或者合约内容太多了，不方便或者无法引用到当前合约的话，那么我们就需要通过接口调用的方法了，但是需要知道被调用合约的地址和函数的描述，就是合约方法名字和参数一定要对应上

部署一个合约，合约里面有个`function setX(uint _x)external`函数

​									`接口类型名`(`被调用合约的地址`).`合约方法`

`interfaceCall.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

// 用一个新的接口合约  名字随便起
// 写一个接口合约  把这个合约你要调用的方法写个抽象方法 方法名和参数要一致
interface anyName{
    function setX(uint _y)external;
}
contract callInterface{
    function example(address _test)external{
        //按照这样的格式调用
        anyName(_test).setX(10);
    }
}
```

### 6.3低级call

使用低级的call调用合约的话，需要指定函数名字和添加参数，这个传入给call的参数格式是有ABI编码所规定的的

可以借助ABI提供的编码接口来编码我们调用的函数名和参数

如果低级call调用的函数是合约中不存在的，注意也是会调用成功的，那么就要看合约是否有回退函数了，关于回退函数，后面会继续介绍

`call.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract test{
    uint public x;
    function setX(uint a)external {
        x = a;
    }
}

contract Call{
    function example(address _test)external returns(bool success,bytes memory data){
        (success,data)=_test.call(abi.encodeWithSignature("setX(uint256)",123));
    }

     function example1(address _test)external returns(bool success,bytes memory data){
        (success,data)=_test.call(abi.encodeWithSignature("setB(uint256)",122));
    }
}
```

### 4、委托调用

普通的调用，就是a调用b，b调用c，在c的视角看来，是b在调用它 并且c合约可以改变自己的状态变量

委托调用  如果b发起委托调用c   那么c看来是a在调用它，但是这样的调用无法通过c合约改变状态变量，同时也不能收到调用的主币，交易的主币保存在B合约中

利用委托合约  形成可升级合约的范式

同时委托合约的变量和被调用合约的变量设置要保持一致，要不会形成很奇怪的结果，是顺序保持一致，比如说 被调用合约有变量，ABCD，委托合约有123   这样设置ABC的时候就不会出错，但是如果被调用的合约变量的顺序是DABC，那么就会出错



这里再看一遍视频再整理一下   介绍的时候是三个对象之间操作，为啥案例中就两个呢



## 7、可支付性和回退函数

在智能合约中，有一个非常重要的概念那就是货币，在区块链的创世块生成以后，随之而来的就产生了主币，比如以太坊的主币是ETH，比特币的主币是BTC，但是还有一个概念就是ERC20，ERC20是通过智能合约产生的货币，而一条链的主币是随这个区块链产生而伴随的，而且产生新的主币靠旷工挖矿(POW)，而ERC20只是通过智能合约来规定的，ERC20的会在后续的讲解重点介绍

### 7.1payable

`payable`关键字可以用来修饰地址，也可以用来修饰函数

在第二章的时候，我们介绍过，地址类型是分`address`和`address payable`在智能合约中，后者是可以发起交易的

那当修饰函数的时候，表明该函数在调用的时候可以传入主币，如果想要在合约部署的时候就传入主币，构造函数就要加上`payable`

通过调用函数传入主币，主币会存在该合约地址里面

`payable.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract PayAble{
    address payable public  owner;
    constructor(){
        owner = payable(msg.sender); //这里需要用payable强制转化
    }

    // payable修饰函数的话  函数就可以接受主币
    function desposit()external payable{
    }
    
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
```

### 7.2回退函数

如果直接向一个合约地址转入主币的话，当这个合约没有回退函数的时候，会导致转账失败，调用合约不存在的函数也会出错

回退函数主要分为两种`fallback`和`receive`，带有data就会触发fallback，没有receive就触发

调用合约的时候如果发送了主币  有数据的话找fallback 没有数据的话找receive  如果没有receive  那么都会去找fallback

`back.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract back{
    event Log(string func,address sender,uint value);
    //有data的话会触发fallback
    fallback()external payable{
        emit Log("fallback",msg.sender,msg.value);
    }
    // 没有data会触发receive
    receive() external payable{
        emit Log("receive",msg.sender,msg.value);
    }

    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}

```

调用transfer和send给合约地址转账，当触发合约回退函数的时候，在回退函数中设置一个返回string、address、uint的log会报错

### 7.2发送主币

`payable`修饰的地址可以在合约中时候transfer、send、和call发起转账，注意在合约中发起转账的话，那这个钱是从合约当中扣除，如果合约没钱了，那就会报错

三种发送方法   transfer send call

Transfer 2300gas   失败会revert

Send 2300gas   返回是否成功的bool

call 发送所有的剩余的gas  返回书否成功的bool和data数据

`trans.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract SendEth{
    constructor() payable{

    }
    receive() external payable{}
    function sendViaTransfer(address payable _to)external payable {
        _to.transfer(123);//发的是123个wei
    }
    function sendViaSend(address payable _to)external payable {
        bool success = _to.send(123);
        require(success,"send fail");
    }
    function sendViaCall(address payable _to)external payable {
       (bool success,)= _to.call{value:123}("");//注意语法的不一样  后面的括号指的是附带的数据
       require(success,"call fail");
    }

}
contract ETHReceiver{
    event Log(uint amount,uint gas,address to);
    receive()external payable{
        emit Log(msg.value,gasleft(),msg.sender);
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}
```

合约可以存入主币的方法两种  

​			构造函数加上payable：这个是在部署的时候可以传入主币

​			加上payable的回退函数：这个合约地址就能够接受主币的转账

​			函数加上payable：那么在函数调用的时候就能够传入主币

# 第六章：事件

Solidity 事件是EVM的日志功能之上的抽象。 应用程序可以通过以太坊客户端的RPC接口订阅和监听这些事件，也就是如果某个方法执行完成以后触发一下事件，那么就可以去通过RPC订阅事件，看方法是否执行完成，或者也可以把执行的结果返回

事件是从 EVM 日志中提取出来的片段，为了方便解析它，事件类似于函数的 ABI 。事件有事件名和参数列表，编码时把参数列表分成两份，一份是带有 `indexed` 标识的参数列表（对于非匿名事件里面至多三个参数，对于匿名事件至多4个参数，在编写合约时也有这样的限制），另一部分则是无这个标识的参数列表。标有 `indexed` 的参数列表会和事件签名的 Keccak 哈希共同构成日志中的特殊数据结构 `topics`(这种数据结构便于检索)。无 `indexed` 标识的参数列表会根据普通类型的编码规则，生成序列

也就是说如果定义的事件触发以后，想要获得事件中的参数，那么可以在事件定义的时候参数加上`indexed`

详细地，事件的结构如下：

`address`：由 EVM 自动提供的事件所在合约的地址；

`topics[0]`：`keccak(事件名+"("+EVENT_ARGS.map(canonical_type_of).join(",")+")")`
`EVENT_ARGS.map(canonical_type_of).join(",")` 表示事件的每个参数对应的类型，类型之间用逗号分开。例如，对 `event myevent(uint indexed foo,int b)`，那么`topics[0]=keccak(myevent(uint,int))`。
如果事件被声明为 `anonymous`，那么 `topics[0]` 不会被生成；

`topics[n]`：`EVENT_INDEXED_ARGS[n - 1]`
`EVENT_INDEXED_ARGS[n-1]` 是带有 `indexed` 标识的参数列表中下标为 `n-1` 的参数，即第 `n` 个参数；这个式子表示每个 topics 结构里面的内容是什么。

`data`：`abi_serialise(EVENT_NON_INDEXED_ARGS)`
`EVENT_NON_INDEXED_ARGS` 是不带有 `indexed` 标识的事件参数，`abi_serialise()` 把参数列表 ABI 编码，相当于前面提到的 `enc()` 编码函数。

关于设计原理的说明：

对于复杂的类型（超过 32 个字节或者时动态类型），比如结构体、`bytes`、`string`，编码的前面有 `keccak` 能够高效的检索这样的类型变量，但是也增加了解析的复杂度。因此，要精心设计将需要检索的参数标上 `indexed`，不需要检索而定位后直接获取的变量就不带 `indexed`。当然也可以制造冗余，每个变量都设置一个 带 `indexed` 的参数和不带 `indexed` 的参数，但是部署合约时 gas 会更高，调用消耗也会更高。

`event.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Event{
    event Log(string message,uint val);

    // 事件中可以添加很多的变量参数，但是不能超过三个
    event indexedLog(address indexed sender,uint val);

    // 引入了事件的话  就不能使用view  或者pure的关键字了
    function example()external{
        emit Log("wp",15000);
        emit indexedLog(msg.sender,13000);
    }

    event Message(address indexed _from,address indexed _to,string message);
    function example1(address _to,string calldata _message)external{
        emit Message(msg.sender,_to,_message);
    }
}
```

我们可以在交易的输出里面查看的到关于事件触发以后的详情，其实事件触发以后参数更多的是反馈给DAPP，那怎么通过前端订阅事件，后续我也会出关于DAPP开发的教程，这里暂时就不详细展开了

# 第七章：数组

## 1、基本介绍

数组可以在声明时指定长度，也可以动态调整长度，如果在申明的时候没有固定长度，其实是没有创建存储空间，那么就不能通过下标直接访问

一个元素类型为 `T`，固定长度为 `k` 的数组可以声明为 `T[k]`，而动态数组声明为 `T[]`

数组元素可以是任何类型，包括映射或结构体，对类型的限制是映射只能存储在存储`storage `中，并且公开访问函数的参数需要是 ABI 类型

### 1.1数组成员

`length`

数组有 `length` 成员变量表示当前数组的长度。 一经创建，内存memory 数组的大小就是固定的

`push()`

动态的存储storage 数组以及 `bytes` 类型（ `string` 类型不可以）都有一个 `push()` 的成员函数，它用来添加新的零初始化元素到数组末尾，并返回元素引用． 因此可以这样： `x.push().t = 2` 或 `x.push() = b`.

`push(x)`

动态的 存储storage 数组以及 `bytes` 类型（ `string` 类型不可以）都有一个 `push(ｘ)` 的成员函数，用来在数组末尾添加一个给定的元素，这个函数没有返回值．

`pop()`

变长的 存储storage 数组以及 `bytes` 类型（ `string` 类型不可以）都有一个 `pop()` 的成员函数， 它用来从数组末尾删除元素。 同样的会在移除的元素上隐含调用 `delete `

### 1.2数组操作

对于一个未声明长度的动态数组，不能通过指定下标来定义数组的元素，因为没有开辟存储空间，必须通过`push`把元素传入数组的尾部

定长的数组，通过下标访问数组元素，不能通过`push`和`pop`，因为会改变数组的长度

`delete`关键字删除数组元素的话和`pop`一样的是会将元素改为默认值，不会删除长度

在函数中创建的数组必须要加关键字`memory`或者`calldata`

`arryBasic.sol`

```solidity
// SPDX-License-Identifier:MIT

pragma solidity ^0.8;

contract testArray{
    uint[] public num;
    uint[3] public numFixed;

    uint public len1 = num.length;  //长度为0  
    uint public len2 = numFixed.length;


    //定义时赋初始值的方式
    uint[] public num1 = [1,2];
    uint[3] public numFixed1 = [3,4,5]; 

    uint public innerlen;
    
    function example()external{
        //num[0]=1;  不能直接通过下标传入  调用的时候会报错   因为此时的数字长度为0
        
        num.push(1);//动态数组像尾部添加数据，和Go的append相似
        num[0] = 5; //push一次数组的长度增加了1   这个时候就可以通过下标来访问数组了

        num.pop();  //pop以后数  会删除最后一个元素 长度减一  
        // 在这里如果访问num[0]的话会报错   所以以后养成好的习惯  访问数组前先判断一下数组的长度

        num.push(2);
        num.push(3);

        delete num[0];//删除  但是不会减少长度  改成默认值
        
        // 局部变量
        uint[] memory  a =new uint[](5); //函数中不能创建动态数组  要指定长度
        innerlen = a.length;
        
        // 局部的数组 push 和pop都不能用  会改变长度
        a[0]=1;  //定长的数组 
    }
    function example1()external{
        num.push() = 1000;
        num.push()= 500;
    }
}
```

在函数中引用状态数组变量的话，可以通过meomory和storage关键字来设置是值传递还是引用传递

`arryBasicPuls.sol`

```solidity
// SPDX-License-Identifier:MIT

pragma solidity ^0.8;

contract testArray{
    uint[] public num;
    uint[3] public numFixed = [1];
    function arryReturn()external  returns(uint[] memory ){
        num.push(1);
        num.push(2);
        //uint[] memory a = num;  //如何把状态变量复刻下来
        uint[] storage a = num;  //如何把状态变量复刻下来
        a[0]=5;   
        return num;
        //return a;
    }

}
```

## 2、bytes和string

### 2.1定长字节数组

bytes1，bytes2，bytes3， …， bytes32 是存放1，2，3，直到 32 个字节的字节序列，它们看成是数组，比较特别的是，它们也可以比较大小，移位，但是不能够进行四则运算

字符是以ASIIC码的值，转化成16进制存储

byte作为bytes1的别名（在0.8.0之前）

可以使用`.length`获取字节数，即字节数组长度，注意获取的是字节数

`byte.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract bytes123{
    bytes1 public b1 = 'a';
    bytes2 public b2 = "ab"; //最终显示结果会以两个字节显示
    bytes32 public b32 = "a";//最终显示结果会以32个字节显示，空位补0
    uint public len  = b32.length;
}
```

### 2.2变长字节数组

我们更多时候应该使用 `bytes` 而不是 `bytes1[]`，因为Gas 费用更低, 在 内存memory 中使用 `bytes1[]` 时，会在元素之间添加31个填充字节。 而在 存储storage 中，由于紧密包装，这没有填充字节， 作为一个基本规则，对任意长度的原始字节数据使用 `bytes`，对任意长度字符串（UTF-8）数据使用 `string`

如果想要访问以字节表示的字符串 `s`，请使用 `bytes(s).length` / `bytes(s)[7] = 'x';`。 注意这时你访问的是 UTF-8 形式的低级 bytes 类型，而不是单个的字符

`string` 与 `bytes` 相同，但不允许用长度或索引来访问，而bytes可以

Solidity 没有字符串操作函数但是可以使用第三方的字符串库，不过可以使用keccak256-hash来比较两个字符串`keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2))`，或者使用`bytes.concat(bytes(s1), bytes(s2))`、 `string.concat`来连接两个字符串

`stirngOpt.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;  

contract testStringOpt {
    string public greet = "Hello, ";
   
    string public s1 = "A";
    string public s2 = "A";

    bytes public b1 = abi.encodePacked(s1);
    bytes public b2 = abi.encodePacked(s2);

    function isEqual()external view returns(bool){
        if(keccak256(b1)==keccak256(b2)){
            return true;
        }
        return false;
    }

    function str(string calldata a) public view  returns (string memory){
        return string(bytes.concat(bytes(greet),bytes(a)));
    }
    function str1() public view  returns (string memory){
        return string.concat(s1,s2);
    }
}
```

## 3、数组切片

目前数组切片，仅可使用于 calldata 数组

数组切片是数组连续部分的视图，用法如：`x[start:end]` ， `start` 和 `end` 是 uint256 类型（或结果为 uint256 的表达式）。 `x[start:end]` 的第一个元素是 `x[start]` ， 最后一个元素是 `x[end - 1]` 

如果 `start` 比 `end` 大或者 `end` 比数组长度还大，将会抛出异常。

`start` 和 `end` 都可以是可选的： `start` 默认是 0， 而 `end` 默认是数组长度

数组切片没有任何成员。 它们可以隐式转换为其“背后”类型的数组，并支持索引访问。 索引访问也是相对于切片的开始位置。 数组切片没有类型名称，这意味着没有变量可以将数组切片作为类型，它们仅存在于中间表达式中

`arrySlice.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testArrySlice{
    /// 被当前合约管理的 客户端合约地址
    address client;

    constructor(address client_) {
        client = client_;
    }
    bytes public b = abi.encodePacked("setOwner(address)",0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

    /// 在进行参数验证之后，转发到由client实现的 "setOwner(address)"
    function forward(bytes calldata payload) external {
        bytes4 sig = bytes4(payload[:4]);

        // 由于截断行为，与执行 bytes4(payload) 是相同的
        // bytes4 sig = bytes4(payload);

        if (sig == bytes4(keccak256("setOwner(address)"))) {
            address owner = abi.decode(payload[4:], (address));
            require(owner != address(0), "Address of owner cannot be zero.");
        }
        (bool status,) = client.delegatecall(payload);
        require(status, "Forwarded call failed.");
    }
}
```

这个用法对于ABI编码的截取提供了方法

## 4、删除数组元素

### 4.1通过移动删除指定元素

通过移动删除指定下标的数组元素，这样删除完以后，原来的元素还是有序的

`moveToDel.sol`

```solidity
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
```

### 4.2通过替换删除指定元素

用最后一个元素过来填充，然后删除最后一个元素

`swapToDel.sol`

```solidity
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
```

# 第八章：Mapping

## 1、基本映射

映射类型在声明时的形式为 `mapping(KeyType => ValueType)`。 其中 `KeyType` 可以是任何基本类型，即可以是任何的内建类型， `bytes` 和 `string` 或合约类型、枚举类型。 而其他用户定义的类型或复杂的类型如：映射、结构体、即除 `bytes` 和 `string` 之外的数组类型是不可以作为 `KeyType` 的类型的。

`ValueType` 可以是包括映射类型在内的任何类型

也就是说`mapping`在定义的时候key的类型有限制，value的类型是没有限制的

`mappingBasic.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testMapping{
    mapping(address=>uint) public balance;
    mapping(address=>mapping(address=>bool)) public isFirend;

    function example()external{
        balance[msg.sender] = 123;
        uint a  = balance[address(1)];//不存在的话则变为默认值
        delete balance[msg.sender];//不删位置，改为默认值

        isFirend[msg.sender][address(this)]=true;
    }
}
```

## 2、迭代映射

利用映射配合其他类型的数据结构，可以实现更加复杂的数据结构

`complexMappig.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testMap{
    mapping(address=>uint) public balance;
    mapping(address=>bool) public isInsert;
    address[] public keys;
    function set(address key,uint value)external{
        balance[key] = value;
        if(!isInsert[key]){
            isInsert[key] = true;
            keys.push(key);
        }
    }
    function getSize()external view returns(uint){
        return keys.length;
    }
    function getSomeOnesBalance(uint i)external view returns(uint){
        return balance[keys[i]];
    }
}
```

通过映射结构去实现更加复杂的结构体，映射知识的实践应用我们会在后续的教程用继续的讲解

# 第九章：结构体

## 1、基本介绍

### 1.1定义的位置

结构体在定义的时候，既能定义在合约的内部，也能定义在合约的外部，区别就相当于是否为全局的意思，那么在该文件下的合约都能够引合约外部的结构体变量

`structPosition.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

struct People{
    string  Name;
    uint Age;
}

contract testP{
    struct Man{
        string  Name;
        uint Age;
    }
    // 注意定义结构体实例的时候 初始化的格式
    People public p = People("wp",25);
    People public p1 = People({Name:"no",Age:0});

    Man public m;
}  
 
contract testP1{
    People public p = People("wp",25);
    // Man public m; 合约内的结构体  除继承其他合约无法直接访问
} 
```

### 1.2基本操作

注意结构体声明的方式，在声明的时候传入字段的值和声明以后传入字段的值，并且如何调用

`structBasicOpt.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract testSBO{
    struct Car{
        string model;
        uint year;
        address owner;
    }
    Car public car;
    Car[] public cars;
    mapping(address=>Car[]) public carsOwner;

    function example()external{
        Car memory toyota = Car("Toyota",1990,msg.sender);
        Car memory lambo = Car({model:"lambo",year:1980,owner:msg.sender});
        Car memory tesla;
        tesla.model = "tesla";
        tesla.year = 2000;
        tesla.owner = msg.sender;
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari",1920,msg.sender));

        // 值传递获取状态变量
        Car memory _car = cars[0];
        string memory str =  _car.model;

        //引用传递获取状态变量
        Car storage _car1 =car;
        _car1.model="benz"; //这这样修改值的话会同时修改链上的数据

        // 删除方法
        delete _car1.model;
        delete cars[1];
    }
}
```

## 2、应用

目前没有了解到什么比较好的例子，后面遇到的时候在整理

# 第十章：高级编程特性

## 1、库合约

### 1.1基本使用

智能合约中除了`contract`关键字定义合约类型，还有其他类型的关键字可以定义合约，例如`library`定义库合约，`interface`定义接口合约，本节会介绍库合约的使用

根据字面意思去理解，其实库合约的作用就是充当一个函数库，在solidity中，可以用库合约去增强某个类型，那该类型定义的对象就可以直接使用库合约的方法

与合约相比，库的限制：

​	没有状态变量

​	不能够继承或被继承

​	不能接收以太币

​	不可以被销毁

`libararyBasic.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

// 我们定义了一个新的结构体数据类型，用于在调用合约中保存数据。
struct Data {
    mapping(uint => bool) flags;
}

library Set {

  // 注意第一个参数是“storage reference”类型，因此在调用中参数传递的只是它的存储地址而不是内容。
  // 该函数可以被视为对象的方法，则习惯称第一个参数为 `self` //也就是说 其实该方法由第一个参数调用，作用在第一个参数上
  function insert(Data storage self, uint value)public returns (bool){
      if (self.flags[value])
          return false; // 已经存在
      self.flags[value] = true;
      return true;
  }

  function remove(Data storage self, uint value)public returns (bool){
      if (!self.flags[value])
          return false; // 不存在
      self.flags[value] = false;
      return true;
  }

  function contains(Data storage self, uint value)public view returns (bool){
      return self.flags[value];
  }
}

contract C {
    Data knownValues;

    function register(uint value) public {
        // 不需要库的特定实例就可以调用库函数，
        // 因为当前合约就是“instance”。
        require(Set.insert(knownValues, value),"alreadly exsit");
    }
    // 如果我们愿意，我们也可以在这个合约中直接访问 knownValues.flags。
}
```

### 1.2Using For

`using A for B;` 可用于附加库函数（从库 `A`）到任何类型（`B`）

`using A for \*;` 的效果是，库 `A` 中的函数被附加在任意的类型上，这个类型可以使用A内的函数

`usingfor.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

// 我们定义了一个新的结构体数据类型，用于在调用合约中保存数据。
struct Data {
    mapping(uint => bool) flags;
}

library Set {

  // 注意第一个参数是“storage reference”类型，因此在调用中参数传递的只是它的存储地址而不是内容。
  // 该函数可以被视为对象的方法，则习惯称第一个参数为 `self` //采用using for的话 其实该方法由第一个参数调用，作用在第一个参数上
  function insert(Data storage self, uint value)public returns (bool){
      if (self.flags[value])
          return false; // 已经存在
      self.flags[value] = true;
      return true;
  }

  function remove(Data storage self, uint value)public returns (bool){
      if (!self.flags[value])
          return false; // 不存在
      self.flags[value] = false;
      return true;
  }

  function contains(Data storage self, uint value)public view returns (bool){
      return self.flags[value];
  }
}

contract C {
    using Set for Data;
    Data knownValues;

    function register(uint value) public {
        knownValues.insert(value);
    }
}
```

## 2、继承

### 2.1基本使用

当一个合约从多个合约继承时，在区块链上只有一个合约被创建，所有基类合约（或称为父合约）的代码被编译到创建的合约中。这意味着对基类合约函数的所有内部调用也只是使用内部函数调用（super.f（..）将使用JUMP跳转而不是消息调用）

状态变量覆盖被视为错误。 派生合约不可以在声明已经是基类合约中可见的状态变量具有相同的名称 ，也就是说子合约和父合约的状态变量不可以重名

通过关键字`is`实现继承效果

Virtual修饰函数  表明他在子合约中是可以被重写的

override修饰函数  表明他在子函数中重写了

`extendBasic.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract A{
    function funA()external pure virtual returns(string memory ){
        return "A";
    }
    function funAB()external pure virtual returns(string memory ){
        return "AB";
    }
}

contract B is A{
 function funA()external pure override returns(string memory ){
        return "B";
    }
}
```

修改器重写也可以被重写，工作方式和函数重写类似。 需要被重写的修改器也需要使用 `virtual` 修饰， `override` 则同样修饰重载

重写可以改变函数的标识符，规则如下：

​	可见性只能单向从 `external` 更改为 `public`

​	`nonpayable` 可以被 `view` 和 `pure` 覆盖

​	`view` 可以被 `pure` 覆盖

​	`payable` 不可被覆盖

如果有多个父合约有相同定义的函数， `override` 关键字后必须指定所有父合约的名字，且这些父合约没有被继承链上的其他合约重写

`extendBasicPlus.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Base1
{
    function foo() virtual public {}
}

contract Base2
{
    function foo() virtual public {}
}

contract Inherited is Base1, Base2
{
    // 继承自两个基类合约定义的foo(), 必须显示的指定 override
    function foo() public override(Base1, Base2) {}
}
```

如果函数没有标记为 `virtual` ， 那么派生合约将不能更改函数的行为（即不能重写）

`private` 的函数是不可以标记为 `virtual` 的

除接口之外（因为接口会自动作为 `virtual` ），没有实现的函数必须标记为 `virtual`

从 Solidity 0.8.8 开始, 在重写接口函数时不再要求 `override` 关键字，除非函数在多个父合约定义

### 2.2带有构造函数的继承

继承一个带有构造函数的合约，那就需要在继承的时候也传入构造参数，有两种继承传入构造参数的方式

`extendWithConstructor.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
contract Base {
    uint x;
    constructor(uint x) { x = x; }
}

// 直接在继承列表中指定参数
contract Derived1 is Base(7) {
    constructor() {}
}

// 或通过派生的构造函数中用 修饰符 "modifier"
contract Derived2 is Base {
    constructor(uint y) Base(y * y) {}
}
```

### 2.3多线继承

就是继承关系比较复杂的时候 ，注意到底是谁继承谁的关系

例如 Y继承X Z继承Y和X

那么然后在代码上

contract Z is X，Y 要不就会报错  

`multipulExtend.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract A{
    function funA()external pure virtual returns(string memory ){
        return "A";
    }
    function funAB()external pure virtual returns(string memory ){
        return "AB";
    }
}

contract B is A{
 function funA()external pure override virtual returns(string memory ){
        return "B";
    }
}
contract C is A,B{
    // 多线继承的时候  如果两个父类都有同一个方法的时候   那么在重写的时候要指明到底是重写哪一个
 function funA()external pure override(A,B) returns(string memory ){
        return "Z";
    }
}
```

### 2.4运行父级合约

父类合约的运行顺序是按照继承的顺序来运行的   就是Contract C is A,B 先A后B

用super来调用合约名字貌似复杂调用以后会麻烦 所以以后都是用合约名字来命名合约

`useFather.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract A{
    event Log(string message);
    function foo()public virtual {
        emit Log("A.foo");
    }
    function bar()public virtual {
        emit Log("A.bar");
    }
    
}
contract E is A{
   
    function foo()public virtual override {
        emit Log("E.foo");
    }
    function bar()public virtual override {
        emit Log("E.bar");
        super.bar();
    }
    
}
contract F is A{
   
    function foo()public virtual override {
        emit Log("F.foo");
    }
    function bar()public virtual override {
        emit Log("F.bar");
        //super.bar();
    }
    
}
contract B is F,E{
    function foo()public virtual override(E,F){
        emit Log("B.foo");
        A.foo();//这个函数是public的才能调用   第一种 通过函数名去调用   爷爷层次的合约也可以直接调用
    }
    function bar()public virtual override(E,F){
        super.bar();//第二种   通过super调用
    }
}
```

## 3、抽象合约

如果合约至少有一个函数没有完成 (例如：`function foo(address) external returns (address);`)，则该合约会被视为抽象合约，需要用 `abstract` 标明

函数没有具体的实现（没有实现体 `{ }` , 而是以 `;` 结尾

抽象合约不能直接实例化，也就是不能部署，如果抽象合约本身确实都有实现所有定义的函数，也是正确的。 下例显示了抽象合约作为基类的用法

如果合约继承自抽象合约，并且没有通过重写来实现所有未实现的函数， 它依然需要标记为抽象 abstract 合约

`abstract.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;
abstract contract Feline {
  function utterance() public pure virtual returns (bytes32);
}

contract Cat is Feline {
  function utterance() public pure override returns (bytes32) { return "miaow"; }
}
```

## 4、接口及多态

### 4.1接口

接口合约也是合约种类的一种，用关键字`interface`定义

接口和抽象合约的作用很类似，但是它的每一个函数都没有实现，而且不可以作为其他合约的子合约，只能作为父合约被继承

接口类似于抽象合约，但是它们不能实现任何函数。还有进一步的限制：

​	无法继承其他合约,不过可以继承其他接口

​	接口中所有的函数都需要是 external，尽管在合约里可以是public

​	无法定义构造函数

​	无法定义状态变量

​	不可以声明修改器

就像继承其他合约一样，合约可以继承接口。接口中的函数都会隐式的标记为 `virtual` ，意味着他们会被重写并不需要 `override` 关键字

接口可以继承其他的接口，遵循同样继承规则

`interface.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

interface IERC20{
    
    function balanceOf(address account) external view returns (uint256);
}

interface IERC20Plus is IERC20{
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external override view returns (uint256);
}
interface IERC20Other{
    
    function balanceOf(address account) external view returns (uint256);
}


contract MyERC20 is IERC20Plus,IERC20Other{
    function totalSupply()external override view returns(uint256){

    }
    function balanceOf(address account) external override(IERC20Plus,IERC20Other) view returns (uint256){

    }
}
```

不同合约对接口有不同实现方法，这样也实现了合约接口的多态

## 5、内联汇编

关于内联汇编的知识，目前我掌握的比较少，后面会继续整理

## 6、验证签名



# 第十一章：合约部署

## 1、代理合约部署合约

很多情况下，需要在合约方法在动态运行的时候构建新的合约，这时候通过之前学习的`new`关键字或者`create`还能够满足我们的需求么，其实更多的情况下，合约在实际的情况下需要设置合约拥有者这样的属性，那么通过之前学习的方法创建的新合约，合约拥有者就是合约地址

可以通过代理合约进行call调用的方式修改合约拥有者这样的属性

`proxyDeploy.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Test1{
    address public owner = msg.sender;
    function setOwner(address newOwner)public{
        require(msg.sender == owner,"cant not use this");
        owner = newOwner;
    }
}

contract Test2{
    address public owner  = msg.sender;
    uint public x;
    uint public y;
    uint public value =msg.value;
    // payable 的意思是可以发送主币
    constructor(uint _x,uint _y) payable{
        x = _x;
        y = _y;
    }
}

contract Proxy{
   event Deploy(address);
   fallback() external payable{}
    receive()external payable{}

   function deploy(bytes memory _code)external payable returns(address addr){
    //    内联汇编部署合约  这是个固定写法
       assembly{
        //    create(v,p,n)
        //  v  表示部署合约发送主币的数量
        //  p  机器码在内存中开始的位置
        //  n  机器码的大小
        // 下面三个参数  都是内联汇编中的写法
        addr:=create(callvalue(),add(_code,0x20),mload(_code))
       }
       require(addr != address(0),"deploy fail");
       emit Deploy(addr);
   }
   function excte(address target,bytes memory _data)external payable {
       (bool success,)=target.call{value:msg.value}(_data);
       require(success,"failed");
   }
}

contract Help{
    // 不需要构造函数的
    function getByteCode1()external pure returns(bytes memory){
        bytes memory bytecode = type(Test1).creationCode;
        return bytecode;
    }
    function getByteCode2(uint _x,uint _y)external pure returns(bytes memory){
        bytes memory bytecode = type(Test2).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_x,_y));
    }
    function getCalldate(address _owner)external pure returns(bytes memory){
        return abi.encodeWithSignature("setOwner(address)",_owner);
    }
}
```

## 2、工厂合约部署合约

工厂合约部署合约在去中心化的交易所中有使用这种方式去实现部署每一个交易对合约

`contract.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract Account{
    address public bank;
    address public owner;
    uint public a;
    constructor(address _owner)payable{
        bank = msg.sender;
        owner = _owner;
    }
    function setA(uint _a)external{
        a= _a;
    }
}

contract AccountFactory{
    Account[] public accounts;
    function createAccount(address _owner)external payable{
        // 由于这两个合约是在一起的  可以直接用new   通过import导入的合约也是可以的
        // 用合约类型定义一个变量去接住new的返回值，那么就是合约的地址
        // 添加{}就可以添加主币的值
        Account account = new Account{value:msg.value}(_owner);
        accounts.push(account);
    }
}
```

## 3、合约自毁

合约代码从区块链上移除的唯一方式是合约在合约地址上的执行自毁操作 `selfdestruct` 。合约账户上剩余的以太币会发送给指定的目标，然后其存储和代码从状态中被移除。移除一个合约听上去不错，但其实有潜在的危险，如果有人发送以太币到移除的合约，这些以太币将永远丢失

`selfDestruct.sol`

```solidity
// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract selfDestruct{
    constructor()payable{

    }
    function kill()external {
        // 将合约中的主币发送出去   不接受主币的合约地址 也会被强制接受 
        selfdestruct(payable(msg.sender));
    }

    function test()external pure returns(uint){
        return 123;
    }
}
```

如果要禁用合约，可以通过修改某个内部状态让所有函数无法执行，而是直接回退，这样也可以达到返还以太的目的
