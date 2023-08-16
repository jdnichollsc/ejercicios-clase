// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenizacionDeActivos is ERC20 {
    AggregatorV3Interface internal assetValueFeed;

    constructor(address _assetValueFeed, string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        assetValueFeed = AggregatorV3Interface(_assetValueFeed);
    }

    function emitirTokens(uint256 _amount) external {
        require(msg.sender == owner(), "Solo el propietario puede emitir");
        
        // Emitir tokens al propietario de acuerdo al valor del activo.
    }

    function quemarTokens(uint256 _amount) external {
        require(msg.sender == owner(), "Solo el propietario puede quemar");
        
        // Quemar tokens al propietario y actualizar el valor del activo.
    }
}
