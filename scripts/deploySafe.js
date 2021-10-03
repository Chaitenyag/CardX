const hre = require("hardhat");
const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay * 1000));

async function main() {
  const cxAddress = "0x401192f5dd5d9416CC73B8a38a1Ab78726E09F3c";


  const Safe = await hre.ethers.getContractFactory("Safe");
  const safe = await Safe.deploy(cxAddress);

  await safe.deployed();

  console.log("Safe deployed to:", safe.address);
  
  await sleep(20);
  await hre.run("verify:verify", {
    address: cx.address,
    contract: "contracts/Safe.sol:Safe",
    constructorArguments: [cxAddress],
  })
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
