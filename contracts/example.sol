// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjemploContrato {

    address public owner;

    constructor() {
        owner = msg.sender; // Establece el creador del contrato como el propietario
    }

    //msg.value ->> almacena un valor en Wei (la unidad más pequeña de Ether en ethereum)
    //tx.origin ->> la direccion que originó la transaccion 
    //block.number ->> numero actual de bloque 
    //block.timestamp ->> marca de tiempo Unix segundos 
    //block.difficulty ->> dificultad bloque
    //this -> acceso al scope global del contrato
    //gasleft() ->> devuelve el limite de gas restante de la transaccion
    //address(this) -> dirección actual del contrato mainet o testnet

    function cambiarPropietario(address nuevoPropietario) public {
        require(msg.sender == owner, "Solo el propietario puede cambiarlo");
        owner = nuevoPropietario;
    }
}
