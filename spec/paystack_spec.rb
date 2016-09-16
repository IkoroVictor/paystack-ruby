require 'spec_helper'

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
