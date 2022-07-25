// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract TestStruct{
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
        _car1.model="benz";

        // 删除方法
        delete _car1.model;
        
        delete cars[1];

    }

}