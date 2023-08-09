pragma solidity ^0.8.0;
/**
 * @title Contrato 6: Oracle y External Calls
 * @author 
 * @notice 
 */
interface Oracle {
    function consultarPrecio(string calldata _activo) external returns (uint256);
}

contract ContratoOracle {
    address public owner;
    Oracle public oracleInstance;

    constructor(address _oracleAddress) {
        owner = msg.sender;
        oracleInstance = Oracle(_oracleAddress);
    }

    modifier soloPropietario() {
        require(msg.sender == owner, "Solo el propietario puede llamar a esta funcion");
        _;
    }

    function consultarPrecioActivo(string calldata _activo) public view returns (uint256) {
        return oracleInstance.consultarPrecio(_activo);
    }
}
