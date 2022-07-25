// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract VerifySig{
    function verify(address sig,string memory _text,bytes memory _sig)external pure returns(bool){
        bytes32 texthash = getTextHash(_text);
        bytes32 ethSigHash = getEthSigHasg(texthash);
        return getRecover(ethSigHash,_sig) == sig;
    }

    function getTextHash(string memory _text)public pure returns(bytes32){
        return keccak256(abi.encodePacked(_text));

    }
    function getEthSigHasg(bytes32 texthash)public pure returns(bytes32){
        return keccak256(abi.encodePacked("sig",texthash));

    }

    function getRecover(bytes32 _ethSigHash,bytes memory _sig )public pure returns(address){
        (bytes32 r,bytes32 s,uint8 v) = _spit(_sig);
        return ecrecover(_ethSigHash,v,r,s);
    }
    function _spit(bytes memory _sig)internal pure returns(bytes32 r,bytes32 s,uint8 v){
        require(_sig.length==65,"error1");
        // 内联汇编分割
        assembly{
            r:=mload(add(_sig,32))
            s:=mload(add(_sig,64))
            v:=byte(0,mload(add(_sig,96)))
        }

    }

}