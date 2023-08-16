// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ApuestasDeportivas {
    AggregatorV3Interface internal gameResultFeed;

    constructor(address _gameResultFeed) {
        gameResultFeed = AggregatorV3Interface(_gameResultFeed);
    }

    function realizarApuesta(uint256 _ethAmount, int256 _expectedResult) external payable {
        require(msg.value == _ethAmount, "Monto incorrecto");
        
        // Realiza la apuesta y almacena los detalles.
    }

    function finalizarApuesta() external {
        (, int256 gameResult, , , ) = gameResultFeed.latestRoundData();
        
        // Evaluar el resultado y realizar pagos de acuerdo a las apuestas.
    }
}
