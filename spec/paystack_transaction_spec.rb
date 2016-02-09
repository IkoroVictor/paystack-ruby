require 'spec_helper'
require 'paystack/models/transaction.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"
	
describe PaystackTransaction do
	it "should return a valid transaction object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransaction.new(paystack)
		expect(transaction.nil?).to eq false
	end

	it "should return a list of transactions" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransaction.new(paystack)
		expect(transaction.nil?).to eq false
		list =  transaction.list(1)
		#puts list
		expect(list.nil?).to eq false
	end

	it "should return a valid transaction hashset" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transaction = PaystackTransaction.new(paystack)
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
		transaction = PaystackTransaction.new(paystack)
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
		transaction = PaystackTransaction.new(paystack)
		expect(transaction.nil?).to eq false
		totals =  transaction.totals(1)
		puts totals
		expect(totals.nil?).to eq false
	end

end