// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ContratoClima {
    AggregatorV3Interface internal weatherFeed;

    constructor(address _weatherFeed) {
        weatherFeed = AggregatorV3Interface(_weatherFeed);
    }

    function obtenerTemperatura() external view returns (int256) {
        (, int256 temperature, , , ) = weatherFeed.latestRoundData();
        return temperature;
    }
}
