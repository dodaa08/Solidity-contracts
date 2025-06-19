const { ethers } = require("hardhat");

async function main() {
  const Nft = await ethers.getContractFactory("MarketPlace");
  const nft = await Nft.deploy();

  await nft.waitForDeployment();

  console.log("Marketplace contract deployed to:", await nft.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
