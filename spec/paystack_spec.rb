require 'spec_helper'
require 'paystack.rb'
require 'paystack/objects/card.rb'


public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"

describe Paystack do
	it "should create a valid object" do
		paystack = Paystack.new(public_test_key,private_test_key)
		expect(paystack.nil?).to eq false
	end

	it "should throw a PaystackBadKeyError" do
		begin
			paystack = Paystack.new(public_test_key)
		rescue  => e
			expect(e.instance_of? PaystackBadKeyError).to eq true
		end
		
	end

	it "should throw a PaystackBadKeyError" do
		begin
			paystack = Paystack.new
		rescue  => e
			expect(e.instance_of? PaystackBadKeyError).to eq true
		end
		
	end
	it "should throw a PaystackBadKeyError" do
		begin
			paystack = Paystack.new(nil, private_test_key)
		rescue  => e
			expect(e.instance_of? PaystackBadKeyError).to eq true
		end
		
	end
	it "should throw a PaystackBadKeyError" do
		begin
			paystack = Paystack.new("33444", "444444")
		rescue  => e
			expect(e.instance_of? PaystackBadKeyError).to eq true
		end
		
	end

end
