// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenizacionDeActivos is ERC20 {
    AggregatorV3Interface internal assetValueFeed;

    constructor(address _assetValueFeed, string memory _name, string memory _symbol) 
    ERC20(_name, _symbol) 
    {
        assetValueFeed = AggregatorV3Interface(_assetValueFeed);
    }

    function emitirTokens(uint256 _amount) external {
        require(msg.sender == owner(), "Solo el propietario puede emitir");
        
        (, int256 assetValue, , , ) = assetValueFeed.latestRoundData();
        
        uint256 tokensToMint = uint256(assetValue) * _amount;

        _mint(msg.sender, tokensToMint);
    }

    function quemarTokens(uint256 _amount) external {
        require(msg.sender == owner(), "Solo el propietario puede quemar");
        
        (, int256 assetValue, , , ) = assetValueFeed.latestRoundData();
        
        uint256 tokensToBurn = uint256(assetValue) * _amount;
        _burn(msg.sender, tokensToBurn);
    }
}
