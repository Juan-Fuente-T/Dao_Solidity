// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
 //interface del contrato Payload con la funcion que necesitamos para poder ejecutar la funcion si el resultado de los votos es si
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
 
    // Del id de la propuesta a los datos de la propuesta, para identificar a cada una por numero
    mapping(uint256 => Propuesta) propuestas;
    //variable que identifica a cada propuesta con un numero
    uint256 numPropuestas;
 
    //funcion para crear propuestas que toma por parametro la descripcion y la direccion del contrato payload
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
        //se evalua que no se haya votado ya, por defecto esta en false
        require(!propuesta.votado[msg.sender], "Ya has votado!");
        //se evalua que el voto no sea mayor que 3, si lo es seria erroneo
        require(voto < 3, "Voto incorrecto");

           //se asocia capa voto con un valor de 0 a 2 y se va incrementando su cantidad dentro de propuesta
        if (voto == 0) {
            propuesta.numeroSi++;
        } else if (voto == 1) {
            propuesta.numeroNo++;
        } else if (voto == 2) {
            propuesta.numeroBlancos++;
        }
 
        //se indica que esa direccion ya ha votado en el valor indicado dentro de prpuesta
        propuesta.votado[msg.sender] = true;
    }
 
 //funcion para ejecutarv las propuestas
 function ejecutarPropuesta(uint256 id) public {
        //Se inicializa una variable tipo Propuesta con su id
        Propuesta storage propuesta = propuestas[id];
        //evalua que la propuesta no este ejecutada, en cuyo caso da error
        require(!propuesta.ejecutado, "Esta propuesta ya se ha ejecutado");
        //evalua que el numero de votos positivos sea suficiente para aprobarse(en este caso las votos si deben ser mas del doble de los no)
        require(propuesta.numeroSi > propuesta.numeroNo * 2, "No hay suficients votos");
 
        // Ejecutar la propuesra, realmente habria que hacer Delegate call en lugar de llamar a la función
        IPayload(propuesta.payload).execute();//se envuelve la direccion de payload en la interface y se llama a execute()
        //se da valor ejecutado positivo a la propuesta
        propuesta.ejecutado = true;
    }
 
}