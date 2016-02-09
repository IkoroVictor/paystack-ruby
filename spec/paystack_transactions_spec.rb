require 'spec_helper'
require 'paystack/objects/transactions.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"
	
describe PaystackTransactions do
	it "should return a valid transaction object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransactions.new(paystack)
		expect(transaction.nil?).to eq false
	end

	it "should return a list of transactions" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransactions.new(paystack)
		expect(transaction.nil?).to eq false
		list =  transaction.list(1)
		#puts list
		expect(list.nil?).to eq false
	end

	it "should return a valid transaction hashset" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransactions.new(paystack)
		expect(transaction.nil?).to eq false
		list =  transaction.list(1)
		expect(list.nil?).to eq false
		temp = list["data"][0]
		#puts temp
		hash=transaction.get(temp['id'])
		#puts hash
		expect(hash.nil?).to eq false
		expect(hash['data']['id'].nil?).to eq false

	end

	it "should successfully verify a transaction" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransactions.new(paystack)
		expect(transaction.nil?).to eq false
		list =  transaction.list(1)
		expect(list.nil?).to eq false
		temp = list["data"][0]
		#puts temp
		hash=transaction.verify(temp['reference'])
		#puts hash
		expect(hash.nil?).to eq false
		#expect(hash['data']['id'].nil?).to eq false

	end

	it "should return a list of transaction totals" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransactions.new(paystack)
		expect(transaction.nil?).to eq false
		totals =  transaction.totals(1)
		#puts totals
		expect(totals.nil?).to eq false
	end

	it "should generate a valid token and charge client using token" do
		
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '883', :expiryMonth  => '09', :expiryYear => '19')
		paystack = Paystack.new(public_test_key, private_test_key)
		token = paystack.getToken(card)
		puts token
		expect(token.nil?).to eq false
		transaction = PaystackTransactions.new(paystack)
		result = transaction.chargeToken(token[:token], 100000.00, :email => "ikoro.victor@gmail.com", :reference => Random.new_seed.to_s)
		#puts result
		expect(result.nil?).to eq false
	end

	it "should recharge an authorization for returning customers" do
		
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '883', :expiryMonth  => '09', :expiryYear => '19')
		paystack = Paystack.new(public_test_key, private_test_key)
		token = paystack.getToken(card)
		puts token
		expect(token.nil?).to eq false
		transaction = PaystackTransactions.new(paystack)
		charge = transaction.chargeToken(token[:token], 100000.00, :email => "ikoro.victor@gmail.com", :reference => Random.new_seed.to_s)
		#puts charge
		expect(charge.nil?).to eq false
		result = transaction.chargeAuthorization(charge['data']['authorization']['authorization_code'], charge['data']['customer']['email'], 2000, :reference => Random.new_seed.to_s )
		puts result
		expect(result.nil?).to eq false
		
	end

end