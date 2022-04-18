// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract hijo {

    //msg.data must be empty
    receive() external payable {}

    //called when msg.data is not empty
    fallback() external payable {}

    //Ver el balance de la cuenta y erificar que se pasa el ether correspondiente
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


contract PagarRecompensa{
    address padre;
    uint256 fechaFinHijo;
    uint256 tiempoParaFinalizar;
    bool esTerminadoHijo;
    
    //Cada curso tiene un tiempo de finalizacion por días definido por el padre.
    function abrirCurso(uint256 _tiempoParaFinalizar) public{
        tiempoParaFinalizar = _tiempoParaFinalizar; 
        esTerminadoHijo = false;
    }
    //Verifica que el curso sea finalizado en los días establecidos
    function acabarCurso(uint256  _fechaFinHijo) public{
        fechaFinHijo = _fechaFinHijo;
        if(tiempoParaFinalizar >= fechaFinHijo){
            esTerminadoHijo = true;
        }
    }

    //Trasfiere el ether a la cuenta del hijo si el curso es finalizado
    function pagarRecompensa(address payable hijo) payable public{
        if (esTerminadoHijo){
            hijo.transfer(msg.value);
        }
    }
}