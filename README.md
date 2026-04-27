🏢 Real Estate DAO - Integração Web3 e Smart Contracts

📖 Visão Geral do Projeto

Este projeto demonstra a criação e integração de um ecossistema completo de Finanças Descentralizadas (DeFi) e Governança (DAO) voltado para o mercado imobiliário (Real Estate). 

O objetivo principal foi validar a "Etapa 5" do desenvolvimento, garantindo que a emissão de ativos, a custódia em cofres de rendimento (Staking) e o poder de decisão dos investidores funcionem perfeitamente via Web3.

Todo o desenvolvimento e os testes foram realizados em ambiente seguro de simulação (Remix VM), garantindo que a lógica financeira e de governança fosse estressada e validada antes de qualquer implementação em rede principal (Mainnet).

🏗️ Arquitetura dos Smart Contracts
O ecossistema é composto por três pilares fundamentais, representados por três Smart Contracts interligados:

PropToken.sol (O Ativo):

Contrato padrão ERC-20 com extensão Ownable.

Responsável por representar as frações imobiliárias digitais.

Funções chave testadas: mint (emissão) e approve (permissão de gastos).

StakingRealEstate.sol (O Cofre/Yield):

Contrato de custódia com proteção contra ataques de reentrância (ReentrancyGuard).

Recebe os tokens dos investidores e calcula recompensas baseadas no tempo de bloqueio (Stake).

Funções chave testadas: depositar, sacar e o modificador de cálculo de tempo.

GovernancaDAO.sol (A Democracia on-chain):

Contrato que permite aos detentores de tokens decidirem o futuro do fundo imobiliário.

Utiliza o saldo de Stake para calcular o peso do voto (Voto Proporcional).

Funções chave testadas: criarProposta e votar.

🚀 Fluxo de Execução e Integração Web3 (Passo a Passo)

Abaixo está o ciclo de vida completo do ativo, desde a sua criação até o seu uso em uma votação, validando a integração entre os contratos.

Passo 1: Deploy (Implantação)

PropToken: Implantei o token informando a minha conta como initialOwner.

StakingRealEstate: Implantei o contrato de Staking, passando o endereço do PropToken no construtor. Isso criou o vínculo oficial entre o cofre e o ativo correto.

GovernancaDAO: Implantei a DAO vinculada aos saldos do ecossistema.

Passo 2: Emissão de Ativos (Mint)

Ação: Utilizei a função mint no PropToken.

Objetivo: Criar liquidez inicial, simulando a tokenização de um imóvel e enviando os tokens para a carteira do investidor (Account).

Validação: Verificado através da função balanceOf, confirmando o recebimento dos fundos.

Passo 3: Autorização de Custódia (Approve) - A Chave de Segurança

Ação: Utilizei a função approve no PropToken.

Objetivo: Autorizar o contrato de Staking (no campo spender) a movimentar meus tokens.

Lógica Aprendida: Na Web3, contratos não podem "puxar" fundos da carteira do usuário sem permissão explícita (Padrão ERC-20 Allowance). Sem este passo, o depósito falha.

Passo 4: O Stake (Depositar)

Ação: Chamei a função depositar no StakingRealEstate.

Objetivo: Transferir os ativos da carteira do usuário para o Smart Contract (transferFrom).

Validação: A consulta ao mapeamento saldosStaking retornou o valor exato depositado, provando a comunicação inter-contratos com sucesso.

Passo 5: Governança e Votação Democrática

Criação da Proposta: Executei criarProposta com o tema "Aquisição Banco Master". Isso gerou o ID 0 na blockchain.

Votação: Utilizei a função votar, passando o ID 0 e o voto true (A favor).
