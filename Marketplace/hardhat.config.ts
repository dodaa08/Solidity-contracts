import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

if (!process.env.PRIVATE_KEY || process.env.PRIVATE_KEY.length !== 64) {
  throw new Error("❌ Invalid PRIVATE_KEY: Ensure it's 64 characters long in .env file");
}

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC_URL || "",
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};

export default config;
