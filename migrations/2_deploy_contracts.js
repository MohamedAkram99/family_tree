var Family = artifacts.require("./family.sol");

module.exports = function(deployer) {
  deployer.deploy(Family,"john","jack",200,"father");
};
