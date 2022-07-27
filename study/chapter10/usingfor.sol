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