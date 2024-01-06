// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Lottery {
    address public owner;
    address payable[] public players;

    constructor() {
        owner = msg.sender;
    }

    function enterLotery() external payable {
        require (msg.value > 0 ether, "Enter a valid amount");

        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public onlyOwner {
        uint index = getRandomNumber() % players.length;
        payable(players[index]).transfer(address(this).balance);

        players = new address payable[](0);
    }

    function getBalance() public view returns(uint) {
        return(address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "");
        _;
    }
}
