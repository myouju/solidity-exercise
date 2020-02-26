var GameManager = artifacts.require("GameManager");
var GameDefine = artifacts.require("GameDefine");
var WithdrawalContract = artifacts.require("WithdrawalContract");
module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(GameDefine);
  _deployer.deploy(WithdrawalContract);
  _deployer.deploy(GameManager);
};
