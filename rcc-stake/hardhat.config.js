require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config();
module.exports = {
  solidity: "0.8.27",
  networks: {
    hardhat: {},
    sepolia: {
      url:
          "https://eth-sepolia.g.alchemy.com/v2/" + process.env.ALCHEMY_API_KEY, accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
};