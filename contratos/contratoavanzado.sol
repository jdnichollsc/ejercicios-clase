pragma solidity ^0.8.0;

/**
 * @title Contrato 3: Patrones de Diseño y Control de Acceso
 * @author 
 * @notice 
 */

contract ContratoAvanzado {
    address public owner;
    uint private balance;

    modifier soloPropietario() {
        require(msg.sender == owner, "Solo el propietario puede llamar a esta funcion");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function depositar() public payable {
        balance += msg.value;
    }

    function retirar(uint _cantidad) public soloPropietario {
        require(_cantidad <= balance, "No hay suficiente saldo");
        balance -= _cantidad;
        payable(owner).transfer(_cantidad);
    }

    function getBalance() public view soloPropietario returns (uint) {
        return balance;
    }
}
