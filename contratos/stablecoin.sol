// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Stablecoin is ERC20 {
    AggregatorV3Interface internal assetValueFeed;

    uint256 public peggedValue

    constructor(address _assetValueFeed, uint256 _initialSupply, string memory _name, string memory _symbol) 
    ERC20(_name, _symbol) {
        assetValueFeed = AggregatorV3Interface(_assetValueFeed);
        _mint(msg.sender, _initialSupply);
        peggedValue = 1 ether; // Initial pegged value (1 unit = 1 USD)
    }

    function updatePeggedValue() external {
        (, int256 assetValue, , , ) = assetValueFeed.latestRoundData();
        peggedValue = uint256(assetValue);
    }

    function mint(uint256 _amount) external {
        require(msg.sender == owner(), "Solo el propietario puede emitir");
        _mint(msg.sender, _amount);
    }

    function burn(uint256 _amount) external {
        require(msg.sender == owner(), "Solo el propietario puede quemar");
        _burn(msg.sender, _amount);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        uint256 adjustedAmount = (amount * 1 ether) / peggedValue;
        return super.transfer(recipient, adjustedAmount);
    }
}
