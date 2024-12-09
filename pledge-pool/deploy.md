npm init -y
npm install --save-dev hardhat
npx hardhat
npm install @openzeppelin/contracts
npm install ethers@6 hardhat@^2.17.1 @nomicfoundation/hardhat-ethers@^3.0.0 --save-dev
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost