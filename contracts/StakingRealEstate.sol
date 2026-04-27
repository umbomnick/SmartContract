// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract StakingRealEstate is ReentrancyGuard {
    IERC20 public propToken;

    mapping(address => uint256) public saldosStaking;
    mapping(address => uint256) public tempoUltimaAtualizacao;
    mapping(address => uint256) public recompensasAcumuladas;

    uint256 public taxaRecompensa = 10; 

    constructor(address _enderecoPropToken) {
        propToken = IERC20(_enderecoPropToken);
    }

    modifier atualizarRecompensa(address _conta) {
        // CORREÇÃO: Só calcula recompensa se o usuário já tiver saldo e tempo registrado
        if (saldosStaking[_conta] > 0) {
            recompensasAcumuladas[_conta] = calcularRecompensaAtual(_conta);
        }
        tempoUltimaAtualizacao[_conta] = block.timestamp;
        _;
    }

    function calcularRecompensaAtual(address _conta) public view returns (uint256) {
        if (saldosStaking[_conta] == 0 || tempoUltimaAtualizacao[_conta] == 0) {
            return recompensasAcumuladas[_conta];
        }
        uint256 tempoEmStaking = block.timestamp - tempoUltimaAtualizacao[_conta];
        uint256 novaRecompensa = (saldosStaking[_conta] * tempoEmStaking * taxaRecompensa) / 100;
        return recompensasAcumuladas[_conta] + novaRecompensa;
    }

    function depositar(uint256 _quantidade) external nonReentrant atualizarRecompensa(msg.sender) {
        require(_quantidade > 0, "A quantidade deve ser maior que zero");
        
        // Primeiro transfere (Segurança), depois atualiza saldo
        propToken.transferFrom(msg.sender, address(this), _quantidade);
        saldosStaking[msg.sender] += _quantidade;
    }

    function sacar(uint256 _quantidade) external nonReentrant atualizarRecompensa(msg.sender) {
        require(saldosStaking[msg.sender] >= _quantidade, "Saldo insuficiente no cofre");
        saldosStaking[msg.sender] -= _quantidade;
        propToken.transfer(msg.sender, _quantidade);
    }

    function resgatarRecompensas() external nonReentrant atualizarRecompensa(msg.sender) {
        uint256 recompensa = recompensasAcumuladas[msg.sender];
        require(recompensa > 0, "Nenhuma recompensa disponivel");
        recompensasAcumuladas[msg.sender] = 0;
        propToken.transfer(msg.sender, recompensa);
    }
}