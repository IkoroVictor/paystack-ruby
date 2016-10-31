require 'spec_helper'
require 'paystack/objects/banks.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"

describe PaystackBanks do

	it "should return a list of banks" do
		paystack = Paystack.new(public_test_key, private_test_key)
		banks = PaystackBanks.new(paystack)
		expect(banks.nil?).to eq false
		list =  banks.list(1)
		expect(list.nil?).to eq false
	end

end
