// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
 
interface IPayload {
    function execute() external;
}
 
contract Governance {
 
 //Un struct Propuesta contiene todos los datos de la propuesta, le da estructura
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
 
    // Del id de la propuesta a los datos de la propuesta, para identificar a cada una por numero
    mapping(uint256 => Propuesta) propuestas;
    //variable que identifica a cada propuesta con un numero
    uint256 numPropuestas;
 
    //funcion para crear propuestas que toma por parametro la descripcion y la direccion de payload
    function crearPropuesta(
        string calldata descripcion,
        address payload
    ) public {
        //se crea una variable propuesta de tipo propuesta como un numero identificador y se guarda en storage
        Propuesta storage propuesta = propuestas[numPropuestas];
        //se da valor a los siguientes elementos del struct Propuesta para esta propuesta concreta, que la identiica con el numero numPropuestas
        propuesta.creador = msg.sender;
        propuesta.descripcion = descripcion;
        propuesta.payload = payload;
        //se aumenta un numero en el numero identificador para asociarlo a la siguiente propuesta
        ++numPropuestas;
    }
        //funcion para votar propuestas, toma por parametro el numero para identificar propuesta y el voto
        function votarPropuesta(uint256 id, uint256 voto) public {
        Propuesta storage propuesta = propuestas[id];
        //se evalua que ¿¿¿¿¿¿¿se haya votado ya, por defecto esta en false????????????
        require(!propuesta.votado[msg.sender], "Ya has votado!");
        //se evalua que el voto no sea mayor que 3, si lo es seria erroneo
        require(voto < 3, "Voto incorrecto");
 
     
 