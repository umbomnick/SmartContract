// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importamos a interface do nosso contrato de Staking para verificar os saldos
interface IStaking {
    function saldosStaking(address _conta) external view returns (uint256);
}

/**
 * @title GovernancaDAO
 * @dev Sistema de votação simplificado para a Guilda Imobiliária.
 */
contract GovernancaDAO {
    IStaking public contratoStaking;

    struct Proposta {
        string descricao;
        uint256 votosFavor;
        uint256 votosContra;
        bool executada;
        uint256 fimDaVotacao;
    }

    Proposta[] public propostas;
    mapping(uint256 => mapping(address => bool)) public jaVotou;

    // O construtor liga a DAO ao contrato de Staking
    constructor(address _enderecoStaking) {
        contratoStaking = IStaking(_enderecoStaking);
    }

    /**
     * @dev Cria uma nova proposta (ex: "Comprar Apartamento em Lisboa")
     */
    function criarProposta(string memory _descricao) external {
        propostas.push(Proposta({
            descricao: _descricao,
            votosFavor: 0,
            votosContra: 0,
            executada: false,
            fimDaVotacao: block.timestamp + 3 days // Votação dura 3 dias
        }));
    }

    /**
     * @dev Vota numa proposta. O poder de voto é igual ao saldo em Staking.
     */
    function votar(uint256 _propostaId, bool _apoiar) external {
        Proposta storage proposta = propostas[_propostaId];
        
        require(block.timestamp < proposta.fimDaVotacao, "Votacao encerrada");
        require(!jaVotou[_propostaId][msg.sender], "Ja votou nesta proposta");

        // BUSCA O PODER DE VOTO: Quanto mais PropTokens em Staking, mais peso tem o voto
        uint256 poderDeVoto = contratoStaking.saldosStaking(msg.sender);
        require(poderDeVoto > 0, "Precisa ter tokens em Staking para votar");

        if (_apoiar) {
            proposta.votosFavor += poderDeVoto;
        } else {
            proposta.votosContra += poderDeVoto;
        }

        jaVotou[_propostaId][msg.sender] = true;
    }
}