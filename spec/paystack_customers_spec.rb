require 'spec_helper'
require 'paystack/objects/customers.rb'
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
		#puts list
		expect(list.nil?).to eq false
	end

	it "should return a customer hashset/object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		customers = PaystackCustomers.new(paystack)
		expect(customers.nil?).to eq false
		list =  customers.list(1)
		#puts list
		expect(list.nil?).to eq false
		temp = list["data"][0]
		#puts temp
		hash=customers.get(temp['id'])
		#puts hash
		expect(hash.nil?).to eq false
		expect(hash['data']['id'].nil?).to eq false
	end

	it "should successfuly update a customer" do
		paystack = Paystack.new(public_test_key, private_test_key)
		customers = PaystackCustomers.new(paystack)
		expect(customers.nil?).to eq false
		list =  customers.list(1)
		#puts list
		expect(list.nil?).to eq false
		temp = list["data"][0]
		#puts temp
		hash=customers.update(temp['id'], :first_name => "Victor", :last_name => "Ikoro", :phone => "+2347061544884")
		#puts hash
		expect(hash.nil?).to eq false
		expect(hash['data']['id'].nil?).to eq false
	end

	it "should successfuly create a customer" do
		paystack = Paystack.new(public_test_key, private_test_key)
		customers = PaystackCustomers.new(paystack)
		expect(customers.nil?).to eq false
		temp = Random.new_seed.to_s 
		hash=customers.create(:first_name => "#{temp[0..6]}-person", :last_name => "Ogbonge", :phone => "+23470#{temp[0..6]}",:email => "#{temp[0..6]}@gmail.com")
		puts hash
		expect(hash.nil?).to eq false
		expect(hash['data']['id'].nil?).to eq false
	end


end