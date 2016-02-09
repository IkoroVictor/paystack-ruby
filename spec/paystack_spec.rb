require 'spec_helper'
require 'paystack.rb'
require 'paystack/models/card.rb'


public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"

describe Paystack do
	it "should create a valid object" do
		paystack = Paystack.new(public_test_key)
		expect(paystack.nil?).to eq false
	end

	it "should generate a valid token" do
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '883', :expiryMonth  => '09', :expiryYear => '19')
		paystack = Paystack.new(public_test_key)
		token = paystack.getToken(card)
		expect(token.nil?).to eq false
	end

	it "should generate a valid token and charge client using token" do
		
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '883', :expiryMonth  => '09', :expiryYear => '19')
		paystack = Paystack.new(public_test_key, private_test_key)
		token = paystack.getToken(card)
		puts token
		expect(token.nil?).to eq false

		result = paystack.chargeToken(token[:token], 100000.00, :email => "ikoro.victor@gmail.com", :reference => Random.new_seed.to_s)
		expect(result.nil?).to eq false
	end

end
