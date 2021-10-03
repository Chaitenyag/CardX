const hre = require("hardhat");
const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay * 1000));

async function main() {

  const CX = await hre.ethers.getContractFactory("CX");
  const cx = await CX.deploy();

  await cx.deployed();

  console.log("Cardex deployed to:", cx.address);
  
  await sleep(20);
  await hre.run("verify:verify", {
    address: cx.address,
    contract: "contracts/CX.sol:CX",
    constructorArguments: [],
  })
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
