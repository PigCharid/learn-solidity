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

