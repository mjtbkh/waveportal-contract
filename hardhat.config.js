require('dotenv').config();
require("@nomiclabs/hardhat-waffle");

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
    solidity: "0.8.0",
    networks: {
        rinkeby: {
            url: process.env.ALCHEMY_API_KEY,
            accounts: [process.env.PRIVATE_KEY]
        }
    }
};
