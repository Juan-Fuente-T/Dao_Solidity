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
 
    //funcion para crear propuestas
    function crearPropuesta(
        //se declaran las diguientes variables 
        string calldata descripcion,
        address payload
    ) public {
        //se crea una variable propuesta de tipo propuesta como un numero identificador y se guarda en storage
        Propuesta storage propuesta = propuestas[numPropuestas];
        //se da valor a los siguientes elementos del struct Propuesta para esta propuesta concreta, que la identiica el numero numPropuestas
        propuesta.creador = msg.sender;
        propuesta.descripcion = descripcion;
        propuesta.payload = payload;
        //se aumenta un numero en el numero identificador para asociarlo a la siguiente propuesta
        ++numPropuestas;
    }

        function votarPropuesta(uint256 id, uint256 voto) public {
        Propuesta storage propuesta = propuestas[id];
 
        require(!propuesta.votado[msg.sender], "Ya has votado!");
        require(voto < 3, "Voto incorrecto");
 
        if (voto == 0) {
            propuesta.numeroSi++;
        } else if (voto == 1) {
            propuesta.numeroNo++;
        } else if (voto == 2) {
            propuesta.numeroBlancos++;
        }
 
        propuesta.votado[msg.sender] = true;
    }
 