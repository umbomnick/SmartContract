// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importando os padrões de segurança da OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title PropToken
 * @dev Token ERC-20 fracionável do protocolo Real Estate DAO.
 */
contract PropToken is ERC20, Ownable {
    
    // O construtor define o Nome, a Sigla e quem é o dono inicial (Deployer)
    constructor(address initialOwner) ERC20("PropToken", "PROP") Ownable(initialOwner) {
        // Vamos emitir 1 milhão de tokens iniciais para a carteira que publicou o contrato
        // (10 ** decimals() adiciona os 18 zeros padrão da rede Ethereum)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    /**
     * @dev Função para criar novos tokens.
     * Segurança: Apenas o dono (que futuramente será o contrato de Staking/DAO) pode emitir mais.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}