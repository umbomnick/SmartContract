import { ethers } from "ethers";

// ABI Simplificada para demonstração (as funções que você validou no print)
const ABI = [
  "function mint(address to, uint256 amount) public",
  "function stake(uint256 amount) public",
  "function vote(uint256 proposalId, bool support) public",
  "function name() view returns (string)"
];

async function integracaoWeb3() {
  // 1. Conexão com o Provedor (MetaMask ou Hardhat Node)
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();

  // 2. Instância dos Contratos
  const propToken = new ethers.Contract("ENDERECO_DO_TOKEN", ABI, signer);
  const staking = new ethers.Contract("ENDERECO_DO_STAKING", ABI, signer);
  const dao = new ethers.Contract("ENDERECO_DA_DAO", ABI, signer);

  console.log("Integrando com:", await propToken.name());

  // --- DEMONSTRAÇÕES EXIGIDAS ---

  // A. Mint de NFT/Tokens (Emissão de fração imobiliária)
  console.log("Solicitando Mint...");
  const txMint = await propToken.mint(await signer.getAddress(), ethers.parseEther("100"));
  await txMint.wait();
  console.log("Mint realizado com sucesso!");

  // B. Stake de Tokens (Colocando frações para render)
  console.log("Realizando Stake...");
  const txStake = await staking.stake(ethers.parseEther("50"));
  await txStake.wait();
  console.log("Stake confirmado!");

  // C. Votação na DAO (Decisão sobre novo imóvel)
  console.log("Enviando voto...");
  const txVoto = await dao.vote(1, true); // Votando 'SIM' na proposta 1
  await txVoto.wait();
  console.log("Voto contabilizado na Blockchain!");
}