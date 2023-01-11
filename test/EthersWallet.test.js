const EthersWallet = artifacts.require("EthersWallet");
const truffleAssert = require("truffle-assertions");

contract("EthersWallet", (accounts) => {
  it("El owner debe ser el correcto", async () => {
    let contractInstance = await EthersWallet.deployed();
    assert.equal(contractInstance.getOwner(), accounts[0]);
  });
  it("Si se quiere hacer withdrawAll sin fondos debe mostrar un mensaje de que no hay saldo", async () => {
    let contractInstance = await EthersWallet.deployed();
    await truffleAssert.reverts(
      contractInstance.withdrawAll(),
      "no hay saldo."
    );
  });
});
