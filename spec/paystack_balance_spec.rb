require 'spec_helper'
require 'paystack/objects/balance.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"

describe PaystackBalance do

	it "should return paystack account balance" do
		paystack = Paystack.new(public_test_key, private_test_key)
		balance = PaystackBalance.new(paystack)
		expect(balance.nil?).to eq false
		hash =  balance.get
		expect(hash.nil?).to eq false
		expect(hash['message']).to eq "Balances retrieved"
	end

end
