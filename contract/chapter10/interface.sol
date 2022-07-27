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