// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
 
interface IPayload {
    function execute() external;
}
 
contract Governance {
 
 //Un struct Propuesta contiene todos los datos de la propuesta
    struct Propuesta {
        address creador;
        string descripcion;
        uint256 numeroSi;
        uint256 numeroNo;
        uint256 numeroBlancos;
        address payload;
        // De la dirección a (true si ha votado / false si no ha votado)
        mapping(address => bool) votado;
        //variable booleana que evalua si se ha ejecutado
        bool ejecutado;
    }
 
    // Del id de la propuesta a los datos de la propuesta
    mapping(uint256 => Propuesta) propuestas;
    //variable que identifica a cada propuesta
    uint256 numPropuestas;
 
    //funcion para crear propuestas
    function crearPropuesta(
        string calldata descripcion,
        address payload
    ) public {
        Propuesta storage propuesta = propuestas[numPropuestas];
 
        
        propuesta.creador = msg.sender;
        propuesta.descripcion = descripcion;
        propuesta.payload = payload;
 
        ++numPropuestas;
    }