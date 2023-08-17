// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract GobernanzaDescentralizada {
    AggregatorV3Interface internal dataFeed;

    uint256 public proposalThreshold;

    mapping(address => uint256) public votingPower;

    bool public apruebanDecision;

    constructor(address _dataFeed, uint256 _threshold) {
        dataFeed = AggregatorV3Interface(_dataFeed);
        proposalThreshold = _threshold;
        apruebanDecision = false;
    }

    function proponerDecision(uint256 _value) external {
        // Proponer una decisión basada en datos externos.
        // Consulta al oráculo para determinar si es necesario ejecutar una lógica.
        
        (, int256 externalValue, , , ) = dataFeed.latestRoundData();
        
        if (uint256(externalValue) > proposalThreshold) {
            // Ejecutar la lógica de la decisión propuesta.
            // Por ejemplo, realizar una transferencia de fondos, actualizar un estado, etc.
            apruebanDecision=true;
        }
    }

    function votar(uint256 _value) external {
        require(votingPower[msg.sender] > 0, "Sin poder de voto");
        require(!apruebanDecision, "Aun no es posible aprobar el voto");
        // Registrar votos y calcular resultados.
        // Aquí podrías implementar una lógica para registrar los votos de los usuarios y calcular los resultados.
    }
}
