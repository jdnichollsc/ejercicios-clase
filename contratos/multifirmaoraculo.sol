// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract MultifirmaConOraculo is Ownable {
    //instanciar priceFeed
    AggregatorV3Interface internal priceFeed;

    address[] public propietarios;

    mapping(address => bool) public aprobaciones;

    uint256 public numeroAprobacionesRequeridas;

    uint256 public monto;

    constructor(
        address _priceFeed,
        address[] memory _propietarios,
        uint256 _numeroAprobacionesRequeridas
    ) {
        // _priceFeed 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        priceFeed = AggregatorV3Interface(_priceFeed); //obteniendo del constructor de esa clase el valor de priceFeed
        propietarios = _propietarios;
        numeroAprobacionesRequeridas = _numeroAprobacionesRequeridas;
        monto = 0;
    }

    modifier soloPropietario() {
        require(msg.sender == owner() || aprobaciones[msg.sender], "No autorizado");
        _;
    }

    function aprobar() public {
        require(!aprobaciones[msg.sender], "Ya has aprobado");
        aprobaciones[msg.sender] = true;
    }

    function hacerTransferencia(uint256 _ethAmount) public soloPropietario {
        require(_ethAmount <= address(this).balance, "Fondos insuficientes")
        require(_ethAmount > 0, "Monto inválido");

        (, int256 price, , , ) = priceFeed.latestRoundData(); //nos entrega el valor de ETH en USD

        require(price > 0, "Oráculo no disponible");

        uint256 ethPriceInUsd = uint256(price);

        uint256 usdAmount = (_ethAmount * ethPriceInUsd) / 1e18; //1 ETH = 1e18 wei

        //ya pasa esa información a estar disponible en el contrato
        monto = usdAmount;

        //proceso multifirma generico
        for (uint256 i = 0; i < propietarios.length; i++) {
            require(aprobaciones[propietarios[i]], "Faltan aprobaciones"); // si no se cumple, se retorna toda la función
        }
        
        //limpieza de aprobaciones porque ya sabemos que se cumplio el quorum
        for (uint256 i = 0; i < propietarios.length; i++) {
            aprobaciones[propietarios[i]] = false;
        }

        //realizamos la transferencia
        payable(owner()).transfer(_ethAmount);
    }

    function consultarMonto() public view returns (uint256) {
        return monto; //EL VALOR DE ETH EN USD
    }

    function retirarFondos() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
