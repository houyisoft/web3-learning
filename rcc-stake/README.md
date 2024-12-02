### 部署文档
```
mkdir rcc-stake
cd rcc-stake
npm init -y
npm install --save-dev hardhat @nomicfoundation/hardhat-ethers ethers dotenv
npx hardhat
npm install dotenv
npx hardhat compile
npx hardhat run scripts/deploy.js --network sepolia
npx hardhat test
```