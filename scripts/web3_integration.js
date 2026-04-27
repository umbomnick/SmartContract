// Script de demonstração Etapa 5 - Ethers.js
async function main() {
    const signer = await ethers.provider.getSigner();
    const network = await ethers.provider.getNetwork();
    console.log(`Conectado à rede: ${network.name}`);

    // Endereços (Substitua pelos endereços que aparecem no seu Deploy)
    const tokenAddr = "0xd9145CCE52D386f254917e481eB44e9943F39138"; 

    // 1. Demonstração de MINT
    const token = await ethers.getContractAt("PropToken", tokenAddr);
    console.log("--- Iniciando Mint de Tokens ---");
    const mintTx = await token.mint(await signer.getAddress(), ethers.parseUnits("100", 18));
    await mintTx.wait();
    console.log("Sucesso: 100 tokens PROP emitidos via Ethers.js");

    // 2. Demonstração de STAKE (Lógica)
    console.log("--- Simulando Stake ---");
    console.log("Comando: stakingContract.stake(50)");
    // Aqui você chamaria o contrato de Staking de forma similar

    // 3. Demonstração de VOTAÇÃO (Lógica)
    console.log("--- Simulando Votação na DAO ---");
    console.log("Comando: daoContract.vote(proposalId, true)");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});