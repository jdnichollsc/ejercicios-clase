pragma solidity ^0.8.0;

/**
 * @title Contrato 2: Interacción y Eventos
 * @author 
 * @notice 
 */
contract ContratoInteraccion {
    address public owner;
    uint public valor;
    event ValorActualizado(uint nuevoValor);

    constructor() {
        owner = msg.sender;
    }

    modifier soloPropietario() {
        require(msg.sender == owner, "solo el propietario puede llamar a esta funcion");
        _;
    }

    function setValor(uint _nuevoValor) public soloPropietario {
        valor = _nuevoValor;
        emit ValorActualizado(_nuevoValor);
    }

    function transferirEther(address payable _destinatario) public soloPropietario {
        _destinatario.transfer(address(this).balance);
    }
}
