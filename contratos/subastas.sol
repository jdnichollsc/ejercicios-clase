pragma solidity ^0.8.0;
/**
 * @title Contrato 7: Contrato de Subastas
 * @author 
 * @notice 
 */
contract Subasta {
    address public subastador;
    address public mejorPostor;
    uint public mejorOferta;
    uint public finSubasta;

    constructor(uint _duracionSubasta) {
        subastador = msg.sender;
        finSubasta = block.timestamp + _duracionSubasta;
    }

    modifier soloSubastador() {
        require(msg.sender == subastador, "Solo el subastador puede llamar a esta funcion");
        _;
    }

    modifier duranteSubasta() {
        require(block.timestamp <= finSubasta, "La subasta ha finalizado");
        _;
    }

    function hacerOferta(uint _oferta) public duranteSubasta {
        require(_oferta > mejorOferta, "La oferta no es lo suficientemente alta");
        if (mejorPostor != address(0)) {
            // Devolver fondos al postor anterior
            payable(mejorPostor).transfer(mejorOferta);
        }
        mejorPostor = msg.sender;
        mejorOferta = _oferta;
    }

    function finalizarSubasta() public soloSubastador {
        require(block.timestamp > finSubasta, "La subasta aun no ha terminado");
        require(mejorPostor != address(0), "La subasta no tuvo ofertas");

        payable(subastador).transfer(mejorOferta);
    }
}
