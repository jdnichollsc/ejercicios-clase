// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ApuestaFutbol is Ownable {

    AggregatorV3Interface internal resultFeed;

    enum Resultado { Local, Empate, Visitante }

    struct Apuesta {
        Resultado resultadoElegido;
        uint256 cantidadApostada;
    }

    mapping(address => Apuesta) public apuestas;

    mapping(Resultado => uint256) public totalApostadoPorResultado;

    uint256 public totalApuestas;

    uint256 public montoGanador;

    bool public resultadosAnunciados;

    constructor(address _resultFeed) {
        resultFeed = AggregatorV3Interface(_resultFeed);

        totalApuestas = 0;
        montoGanador = 0;

        resultadosAnunciados = false;
    }

    modifier apuestasAbiertas() {
        require(!resultadosAnunciados, "Resultados anunciados");
        _;
    }

    function hacerApuesta(Resultado _resultadoElegido, uint256 totalaApostar) external payable apuestasAbiertas {
        require(totalaApostar > 0, "Cantidad inválida");
        require(_resultadoElegido >= Resultado.Local && _resultadoElegido <= Resultado.Visitante, "Resultado inválido");
        
        Apuesta storage apuestaActual = apuestas[msg.sender];

        apuestaActual.resultadoElegido = _resultadoElegido;
        apuestaActual.cantidadApostada += totalaApostar;

        totalApostadoPorResultado[_resultadoElegido] += totalaApostar;
        totalApuestas += totalaApostar;
    }

    function anunciarResultados(Resultado _resultadoGanador) external onlyOwner {
        require(!resultadosAnunciados, "Resultados ya anunciados");
        require(_resultadoGanador >= Resultado.Local && _resultadoGanador <= Resultado.Visitante, "Resultado inválido");

        (, int256 resultadoObtenido, , , ) = resultFeed.latestRoundData();
        require(resultadoObtenido >= int256(Resultado.Local) && resultadoObtenido <= int256(Resultado.Visitante), "Resultado del oráculo inválido");

        resultadosAnunciados = true;
        montoGanador = totalApostadoPorResultado[_resultadoGanador];
    }

    function reclamarPremio() external {
        require(resultadosAnunciados, "Esperando resultados");
        require(apuestas[msg.sender].cantidadApostada > 0, "No tienes apuestas");
        require(!apuestas[msg.sender].reclamado, "Ya reclamaste tu premio");

        uint256 premio = (apuestas[msg.sender].cantidadApostada * totalApuestas) / montoGanador;
        
        payable(msg.sender).transfer(premio);
        apuestas[msg.sender].reclamado = true;
    }

    function retirarFondos() external onlyOwner {
        require(resultadosAnunciados, "Esperando resultados");
        uint256 saldoRestante = address(this).balance;
        payable(owner()).transfer(saldoRestante);
    }
}
