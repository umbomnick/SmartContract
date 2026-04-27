// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importa a interface oficial da Chainlink
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/**
 * @title OraculoChainlink
 * @dev Contrato para obter o preço real do par ETH/USD via Chainlink
 */
contract OraculoChainlink {
    AggregatorV3Interface internal precoFeed;

    /**
     * Rede: Sepolia (Ethereum Testnet)
     * Agregador: ETH/USD
     * Endereço oficial: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        precoFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    /**
     * @dev Retorna o preço mais recente do ETH em dólares (com 8 casas decimais)
     */
    function obterPrecoAtual() public view returns (int) {
        (
            /* uint80 roundID */,
            int preco,
            /* uint startedAt */,
            /* uint timeStamp */,
            /* uint80 answeredInRound */
        ) = precoFeed.latestRoundData();
        return preco;
    }
}