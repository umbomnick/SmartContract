import hre from "hardhat";

async function main() {
  console.log("Iniciando simulacao de integracao com Ethers.js...");

  // 1. Obtemos o contrato através do hre.ethers de forma direta
  // O Hardhat v6 prefere que usemos o método diretamente do objeto injetado
  const PropToken = await hre.ethers.deployContract("PropToken");

  console.log("Executando deploy simulado...");

  // 2. Aguarda o deploy terminar
  await PropToken.waitForDeployment();

  const tokenAddress = await PropToken.getAddress();
  console.log("Contrato PropToken implantado em:", tokenAddress);

  // 3. Interação via Ethers.js
  const nome = await PropToken.name();
  const simbolo = await PropToken.symbol();
  
  console.log("-----------------------------------------");
  console.log("Integracao bem-sucedida!");
  console.log(`Token detectado: ${nome} (${simbolo})`);
  console.log("-----------------------------------------");
}

main().catch((error) => {
  console.error("Erro na execucao:", error);
  process.exitCode = 1;
});