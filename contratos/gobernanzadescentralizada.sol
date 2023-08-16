// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract GobernanzaDescentralizada {
    AggregatorV3Interface internal dataFeed;

    uint256 public proposalThreshold;
    mapping(address => uint256) public votingPower;

    constructor(address _dataFeed, uint256 _threshold) {
        dataFeed = AggregatorV3Interface(_dataFeed);
        proposalThreshold = _threshold;
    }

    function proponerDecision(uint256 _value) external {
        // Proponer una decisión basada en datos externos.
    }

    function votar(uint256 _value) external {
        require(votingPower[msg.sender] > 0, "Sin poder de voto");
        
        // Registrar votos y calcular resultados.
    }
}
