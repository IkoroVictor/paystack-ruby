require 'spec_helper'
require 'paystack/objects/transactions.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"

describe PaystackTransactions do
	it "should return a valid transaction object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transactions = PaystackTransactions.new(paystack)
		expect(transactions.nil?).to eq false
	end

	it "should return a list of transactions" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transactions = PaystackTransactions.new(paystack)
		expect(transactions.nil?).to eq false
		list =  transactions.list(1)
		#puts list
		expect(list.nil?).to eq false
	end

	it "should return a valid transaction hashset" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transactions = PaystackTransactions.new(paystack)
		expect(transactions.nil?).to eq false
		list =  transactions.list(1)
		expect(list.nil?).to eq false
		temp = list["data"][0]
		#puts temp
		hash=transactions.get(temp['id'])
		#puts hash
		expect(hash.nil?).to eq false
		expect(hash['data']['id'].nil?).to eq false

	end

	it "should initialize a transaction and expect an authorization url" do
		reference = Random.new_seed.to_s[0..9]
		paystack = Paystack.new(public_test_key, private_test_key)
		transactions = PaystackTransactions.new(paystack)
		expect(transactions.nil?).to eq false
		temp = transactions.initializeTransaction(
		:reference =>  reference,
		:email => "xxxrr@gmail.com",
		:amount => 30000,
		)
		puts temp
		expect(temp.nil?).to eq false
		expect(temp['data']['authorization_url'].nil?).to eq false

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


	it "should recharge an authorization for returning customers.\n Test is bound to fail for invaild reference " do

		#TODO: Manually get valid reference for this test
		# i.e Initailize transaction with your reference, redirect to authorization url, fill card details,
		# if transaction successful, replace your reference with the value below
		reference = "2425847597"

		paystack = Paystack.new(public_test_key, private_test_key)
		transactions = PaystackTransactions.new(paystack)
		expect(transactions.nil?).to eq false

		v = transactions.verify(reference)
		expect(v.nil?).to eq false
		#puts v
		auth = v['data']['authorization']['authorization_code']
		email = v['data']['customer']['email']
		result = transactions.chargeAuthorization(auth, email , 2000, :reference => Random.new_seed.to_s )
		#puts result
		expect(result.nil?).to eq false

	end

end
