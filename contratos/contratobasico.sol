pragma solidity ^0.8.0;
/**
 * @title Contrato 1: Conceptos Básicos - Propiedad y Modificadores
 * @author 
 * @notice 
 */
contract ContratoBasico {
    address public owner;
    uint public valor;

    constructor() {
        owner = msg.sender;
    }

    modifier soloPropietario() {
        require(msg.sender == owner, "Solo el propietario puede llamar a esta funcion");
        _;
    }

    function setValor(uint _nuevoValor) public soloPropietario {
        valor = _nuevoValor;
    }
}
