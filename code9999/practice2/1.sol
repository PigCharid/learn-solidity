// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract controlle{
    event GrantRole(bytes32 indexed role,address indexed account);
    event RevokeRole(bytes32 indexed role,address indexed account);
    //role=>address =>bool
    mapping(bytes32=>mapping(address=>bool)) public roles;

    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    address owner;
    modifier onlyRole(bytes32 _role){
        require(roles[_role][msg.sender],"not mannager");
        _;
    }
    modifier onlyOwner(){
        require(msg.sender == owner,"not owner");
        _;
    }
    function getADMIN()external view onlyOwner returns(bytes32) {
        return ADMIN;
    }
    function getUSER()external view onlyOwner returns(bytes32) {
        return USER;
    }
    constructor(){
        owner = msg.sender;
        _grantRole(ADMIN,msg.sender);
    }

    function _grantRole(bytes32 _role,address _account) internal{
        // 修改了值，一般要像链外暴露事件
        roles[_role][_account] = true;
        emit GrantRole(_role,_account);
    }
    function grantRole(bytes32 _role,address _account) external onlyRole(ADMIN){
        _grantRole(_role,_account);
    }
     function revokeRole(bytes32 _role,address _account) external onlyRole(ADMIN){
        roles[_role][_account] = false;
        emit RevokeRole(_role,_account);
    }
}