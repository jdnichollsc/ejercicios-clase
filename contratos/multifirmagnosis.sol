// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@gnosis.pm/safe-contracts/contracts/GnosisSafe.sol";
import "@gnosis.pm/safe-contracts/contracts/proxies/GnosisSafeProxy.sol";

contract Multifirma {

    function crearMultifirma(address[] memory _propietarios, uint256 _numAprobaciones) public {
        require(_propietarios.length >= _numAprobaciones, "Número de aprobaciones inválido");

        // Crear una instancia del contrato GnosisSafeProxy
        GnosisSafeProxy proxy = new GnosisSafeProxy();

        // Crear una instancia del contrato GnosisSafe
        GnosisSafe safe = new GnosisSafe(address(proxy));

        // Inicializar la billetera multifirma con propietarios y umbrales
        address masterCopy = address(0x0000000000000000000000000000000000001001);
        safe.setup(_propietarios, _numAprobaciones, address(0), bytes(""), masterCopy);

    }
    function liberarFondos(address[] memory _propietarios, uint256 _numAprobaciones) public {
        require(_propietarios.length >= _numAprobaciones, "Número de aprobaciones inválido");

        // Crear una instancia del contrato GnosisSafeProxy
        GnosisSafeProxy proxy = new GnosisSafeProxy();

        // Crear una instancia del contrato GnosisSafe
        GnosisSafe safe = new GnosisSafe(address(proxy));

        // Inicializar la billetera multifirma con propietarios y umbrales
        address masterCopy = address(0x0000000000000000000000000000000000001001);
        safe.setup(_propietarios, _numAprobaciones, address(0), bytes(""), masterCopy);
    }
}
