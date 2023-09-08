# Contrato Governance


El contrato "Governance" es un sistema de gobernanza básico implementado en Solidity que permite a los usuarios crear y votar propuestas. Cada propuesta tiene un creador, una descripción, y puede estar vinculada a un contrato externo (payload) que se ejecutará si la propuesta es aprobada. Los usuarios pueden votar a favor, en contra o en blanco en cada propuesta.

## Funcionalidades

- Crear propuestas con una descripción y una referencia al contrato (payload) que se ejecutará si se aprueba la propuesta.
- Votar en propuestas existentes.
- Ejecutar propuestas que han recibido suficientes votos positivos.

## Uso

### Crear una Propuesta

Para crear una propuesta, utiliza la función `crearPropuesta` proporcionando una descripción y la dirección del contrato payload (si es necesario). Por ejemplo:

``` javascript
function crearPropuesta(string calldata descripcion, address payload) public;
```

### Votar en una Propuesta
Para votar en una propuesta existente, utiliza la función votarPropuesta proporcionando el ID de la propuesta y tu voto (0 para sí, 1 para no, 2 para blanco). Por ejemplo:

``` javascript
function votarPropuesta(uint256 id, uint256 voto) public;
```

###Ejecutar una Propuesta
Si una propuesta ha recibido suficientes votos positivos, puede ser ejecutada utilizando la función ejecutarPropuesta. Esto ejecutará el contrato payload asociado a la propuesta. Por ejemplo:

``` javascript
function ejecutarPropuesta(uint256 id) public;
```

## Contribución
Las contribuciones son bienvenidas. Si deseas contribuir a este contrato o informar sobre problemas, puedes hacerlo a través de las solicitudes pull (pull requests) o los informes de problemas (issues) en este repositorio.

## Licencia
Este contrato se distribuye bajo la Licencia Pública General de GNU (GPL-3.0).
