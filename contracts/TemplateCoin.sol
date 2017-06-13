pragma solidity ^0.4.11;

import './StandardToken.sol';

contract TemplateCoin is StandardToken {
	string public name;
	uint8 public decimals;
	string public symbol;
	string public version = 'T0';

	function () {
		throw;
	}

	function TemplateCoin(
		 uint256 _initialAmount,
		 string _tokenName,
		 uint8 _decimalUnits,
		 string _tokenSymbol
		 ) {
		 totalSupply = _initialAmount;
		 name = _tokenName;
		 decimals = _decimalUnits;
		 symbol = _tokenSymbol;
	 }

	 uint256 tokensCreated = 0;
   uint256 unlockedAt = now + 30 days;

   mapping(address => uint256) payouts;

   // Map addresses
   payouts['0x28a282851a7e04f0cdb604d3ad723a788ce23086'] = 100;
   payouts['0x28a282851a7e04f0cdb604d3ad723a788ce23085'] = 100;
   payouts['0x28a282851a7e04f0cdb604d3ad723a788ce23084'] = 100;

   function payout() {
     if (!payouts[msg.sender]) {
       throw;
     }

		 if (now < unlockedAt) {
			 throw;
		 }

     var payout = payouts[msg.sender];
     payouts[msg.sender] = 0;
		 balances[msg.sender] += payout;
		 tokensCreated += payout;
   }


  function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData)) { throw; }
    return true;
  }

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}

}
