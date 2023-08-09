pragma solidity ^0.8.0;
/**
 * @title Contrato 8: Contrato Multifirma Simple
 * @author 
 * @notice 
 */
contract MultifirmaSimple {
    address[] public propietarios;
    uint public quorum;

    constructor(address[] memory _propietarios, uint _quorum) {
        require(_quorum <= _propietarios.length && _quorum > 0, "Quorum invalido");
        propietarios = _propietarios;
        quorum = _quorum;
    }

    modifier soloPropietario() {
        bool esPropietario = false;
        for (uint i = 0; i < propietarios.length; i++) {
            if (propietarios[i] == msg.sender) {
                esPropietario = true;
                break;
            }
        }
        require(esPropietario, "Solo los propietarios pueden llamar a esta funcion");
        _;
    }

    mapping(uint => bool) public transaccionConfirmada;
    uint public numTransacciones;

    function crearTransaccion() public soloPropietario {
        numTransacciones++;
        transaccionConfirmada[numTransacciones] = false;
    }

    function confirmarTransaccion(uint _idTransaccion) public soloPropietario {
        require(_idTransaccion <= numTransacciones, "ID de transaccion invalido");
        transaccionConfirmada[_idTransaccion] = true;
    }

    function ejecutarTransaccion(uint _idTransaccion) public soloPropietario {
        require(_idTransaccion <= numTransacciones, "ID de transaccion invalido");
        require(transaccionConfirmada[_idTransaccion], "Transaccion no confirmada");

        // Realizar acciones de la transacción
        // ...

        delete transaccionConfirmada[_idTransaccion];
    }
}
