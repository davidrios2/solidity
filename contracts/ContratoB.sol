// SPDX-lincence-Identifier: MIT
pragma solidity ^0.8.6;
interface IContratoA{
    function setNumber(uint256 _number) external payable;
}

contract ContratoB {
    address payable addressA;
    IContratoA private ContratoA;

    constructor(address payable _addressA) public payable {
        addressA = _addressA;
        ContratoA = IContratoA(_addressA);
    }

    function setNumber() public payable {
        ContratoA.setNumber{value: msg.value}(5);
    }

    function callSetSetNumber() public payable {
        (bool sent, ) = addressA.call{value:msg.value, gas: 10000}(abi.encodeWithSignature("setNumber(uint256)", 5));
    }

    function sendETH() public payable {
       bool sent = addressA.send(msg.value);
       require(sent, "Error sending ETH");
    }

    function transferETH() public payable {
        addressA.transfer(msg.value);
    }

    function callETH() public payable {
        (bool sent, ) = addressA.call{value: msg.value, gas: 100000}("");
        require(sent, "Error");
    }

    function callXETH() public payable {
        (bool sent, ) = addressA.call{value: msg.value, gas: 100000}(abi.encodeWithSignature("x(uint256)",5));
        require(sent, "Error");
    }
}