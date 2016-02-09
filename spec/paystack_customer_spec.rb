require 'spec_helper'
require 'paystack/models/customer.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"
	
describe PaystackCustomers do
	it "should return a valid customers object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		customers = PaystackCustomers.new(paystack)
		expect(customers.nil?).to eq false
	end

	it "should return a list of customers" do
		paystack = Paystack.new(public_test_key, private_test_key)
		customers = PaystackCustomers.new(paystack)
		expect(customers.nil?).to eq false
		list =  customers.list(1)
		puts list
		expect(list.nil?).to eq false
	end


end