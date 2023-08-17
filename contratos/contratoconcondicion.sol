// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ContratoConCondicion {
    AggregatorV3Interface internal priceFeed;

    constructor(address _priceFeed) {
        //Instancia ya llena del PriceFeed
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    modifier precioSuperior(uint256 _threshold) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        require(uint256(price) > _threshold, "Precio no es superior");
        _;
    }

    function realizarAccion(uint256 _threshold) public precioSuperior(_threshold) {
        // Realiza la acción si el precio es superior al umbral.
    }
}
