// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
	uint256 totalWaves;
	mapping(address => uint256) wavesByUser;
    mapping(address => uint256) lastWavedOn;
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

	constructor() payable {
		console.log("I AM SMART CONTRACT, POG.");

        seed = (block.timestamp + block.difficulty) % 100;
	}

	function wave(string memory _message) public {
        require(lastWavedOn[msg.sender] + 30 seconds < block.timestamp, "Wait 30 seconds since your last wave!");
        lastWavedOn[msg.sender] = block.timestamp;
        totalWaves += 1;
        wavesByUser[msg.sender] += 1;
		console.log("%s has waved!, they have waved %d time(s)!", msg.sender, wavesByUser[msg.sender]);

        waves.push(Wave(msg.sender,_message, block.timestamp));
        seed = (block.timestamp + block.difficulty + seed) % 100;
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(prizeAmount <= address(this).balance, "Trying to widthdraw more than the contract has.");
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
	}

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

	function getTotalWaves() public view returns (uint256) {
		console.log("We have %d total waves", totalWaves);
		return totalWaves;
	}

}
