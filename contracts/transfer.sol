
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ReceiveEther {

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    //
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract PagarRecompensa{
    address padre;
    address payable[] hijos;
    uint256 [] fechaFinHijos;
    uint256 tiempoParaFinalizar;
    uint256 recompensa;
    bool [] esTerminadoHijos;
    bool esFinalizado;
    
    modifier soloPadre {
        require(padre == msg.sender);
        _;
    }

    constructor() public {
        padre = msg.sender;
    }

    //Cada curso tiene un tiempo de finalizacion por días definido por el padre.
    function abrirCurso(uint256 _tiempoParaFinalizar, uint256 _recompensa) public soloPadre{
        tiempoParaFinalizar = _tiempoParaFinalizar; 
        recompensa = _recompensa;
        for (uint i = 0; i < hijos.length; i++){
            esTerminadoHijos[i] = false;
        }
    }

    function acabarCurso(uint256[] memory _fechaFinHijos) public soloPadre{
        fechaFinHijos = _fechaFinHijos;
        for (uint i = 0; i < hijos.length; i++){
            if(fechaFinHijos[i] < tiempoParaFinalizar){
                esTerminadoHijos[i] = true;
            }
        }
        esFinalizado = true;
    }

    function recompensar(address payable _hijo) public payable soloPadre{
        (bool sent, bytes memory data) = _hijo.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function pagarRecompensa() public {
        require(esFinalizado);
        for (uint i = 0; i < hijos.length; i++){
            if (esTerminadoHijos[i]){
                recompensar(hijos[i]);
            }
        }
    }
      
}