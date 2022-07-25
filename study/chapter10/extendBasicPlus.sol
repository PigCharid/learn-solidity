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