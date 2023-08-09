pragma solidity ^0.8.0;
/**
 * @title Contrato 4: Herencia y Factory Pattern
 * @author 
 * @notice 
 */
contract ContratoHerencia {
    address public owner;

    constructor() {
        owner = msg.sender;
    }
}

contract ContratoHijo is ContratoHerencia {
    uint public valor;

    function setValor(uint _nuevoValor) public {
        require(msg.sender == owner, "Solo el propietario puede llamar a esta funcion");
        valor = _nuevoValor;
    }
}

contract FactoryContratosHijo {
    address[] public contratosCreados;

    function crearContratoHijo() public {
        ContratoHijo nuevoContrato = new ContratoHijo();
        contratosCreados.push(address(nuevoContrato));
    }
}
