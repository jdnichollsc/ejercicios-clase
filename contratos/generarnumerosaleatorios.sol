// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract GeneradorNumerosAleatorios is VRFConsumerBase {

    bytes32 internal keyHash;
    uint256 internal fee;

    uint256 public numeroAleatorio;

    constructor(address _vrfCoordinator, address _linkToken, bytes32 _keyHash, uint256 _fee)
        VRFConsumerBase(_vrfCoordinator, _linkToken)
    {
        keyHash = _keyHash;
        fee = _fee;
    }

    function solicitarNumeroAleatorio() public {
        require(LINK.balanceOf(address(this)) >= fee, "Fondos insuficientes");
        requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        numeroAleatorio = randomness;
    }
}
