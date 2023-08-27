const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" 
    },
    sepolia: {
      provider: () => new HDWalletProvider('capital mobile stand angle winter fluid tired emotion topple stage betray double', 'https://sepolia.infura.io/v3/47103bfaa2034c1ca6f02fa9b2f0007b'),
      network_id: 11155111,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },
  compilers: {
    solc: {
      version: "^0.8.0"
    }
  }
};
