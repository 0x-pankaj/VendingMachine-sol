// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract vendingMachine {
    address public owner;
    mapping ( address => uint ) public donutsBalances;

    constructor(){
        owner = msg.sender;
        donutsBalances[address(this)]=100;
    }
    function getVendingMachineBalances() public view returns(uint ){
        return donutsBalances[address(this)];
    }
    function restock(uint _amount) public{
        require(msg.sender==owner,"only the owner can restock this machine");
        donutsBalances[address(this)] += _amount;
    }
    function purchase(uint amount) public payable {
        require(msg.value >= amount*2 ether  , "you must pay atleast 2 ether");
        require(donutsBalances[address(this)]>= amount,"not enough donuts in stock.");
        donutsBalances[address(this)] -= amount;
        donutsBalances[msg.sender] += amount;
    }
    receive() external payable {}
    }
