const XUniverseToken = artifacts.require("XUniverseToken");
const SimpleTwitter = artifacts.require("SimpleTwitter");

module.exports = function(deployer) {
    // Deploy the token first
    deployer.deploy(XUniverseToken, 1000000 * 10 ** 18).then(function() {
        // Use the deployed token to deploy SimpleTwitter
        return deployer.deploy(SimpleTwitter, XUniverseToken.address);
    });
};
