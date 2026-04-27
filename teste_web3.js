(async () => {
  try {
    const contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
    const abi = [
      "function name() view returns (string)",
      "function mint(address to, uint256 amount) public"
    ];

    const provider = new ethers.BrowserProvider(window.web3.currentProvider);
    const signer = await provider.getSigner();
    const contrato = new ethers.Contract(contractAddress, abi, signer);

    console.log("--- TESTE DE INTEGRAÇÃO WEB3 ---");
    const nome = await contrato.name();
    console.log("Nome do Token:", nome);

    console.log("Executando Mint via Ethers.js...");
    const tx = await contrato.mint(await signer.getAddress(), ethers.parseUnits("100", 18));
    console.log("Transação enviada! Hash:", tx.hash);
    
    await tx.wait();
    console.log("✅ INTEGRAÇÃO CONCLUÍDA COM SUCESSO!");
  } catch (e) {
    console.error("Erro:", e.message);
  }
})();