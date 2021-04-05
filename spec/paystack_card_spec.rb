require 'spec_helper'
require 'paystack/objects/card.rb'


describe PaystackCard do
	it "should be valid" do
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '883', :expiryMonth  => '09', :expiryYear => '24')
		expect(card.isValidCard).to eq true
	end

	it "should be invalid" do
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '9343450131001381', :cvc => '883', :expiryMonth  => '09', :expiryYear => '24')
		expect(card.isValidCard).to eq false
	end

	it "should be invalid" do
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '83', :expiryMonth  => '09', :expiryYear => '12')
		expect(card.isValidCard).to eq false
	end

	it "should be invalid" do
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '83', :expiryMonth  => '12', :expiryYear => '18')
		expect(card.isValidCard).to eq false
	end

	it "should be invalid" do
		card = PaystackCard.new(:name => 'Victor Ikoro', :number => '4123450131001381', :cvc => '838', :expiryMonth  => '09', :expiryYear => '12')
		expect(card.isValidCard).to eq false
	end


end