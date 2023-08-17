// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ContratoDeSeguro {
    AggregatorV3Interface internal weatherFeed;

    constructor(address _weatherFeed) {
        weatherFeed = AggregatorV3Interface(_weatherFeed);
    }

    function comprarSeguro(uint256 _premium) external payable {
        require(msg.value == _premium, "Prima incorrecta");
        // Almacena detalles del seguro.
    }

    function reclamar() external {
        (, int256 weatherResult, , , ) = weatherFeed.latestRoundData();
        // Evaluar el resultado climático y procesar la reclamación.
        // Realizar un evento o disparara una función
    }
}
