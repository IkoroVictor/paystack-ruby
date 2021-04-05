require 'spec_helper'
require 'paystack/objects/recipients.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"
	
describe PaystackRecipients do
	it "should return a valid recipients object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		plans = PaystackRecipients.new(paystack)
		expect(plans.nil?).to eq false
	end

	it "should return a list of recipients" do
		paystack = Paystack.new(public_test_key, private_test_key)
		plans = PaystackRecipients.new(paystack)
		expect(plans.nil?).to eq false
		list =  plans.list(1)
		puts list
		expect(list.nil?).to eq false
	end

  #Skipping test as it requires nuban account validation and test payment accounts do not work
	xit "should successfuly create a recipient" do
		paystack = Paystack.new(public_test_key, private_test_key)
		recipients = PaystackRecipients.new(paystack)
		expect(recipients.nil?).to eq false
		temp = "Random.new_seed.to_s"
		hash=recipients.create(
			:type => "nuban", #Must be nuban
			:name => "#{temp[0..2]} Test Plan",
			:description => "Dev Test Receipt transfer",
			:account_number => "0000000000", #10 digit account number
			:bank_code => "011", #First bank
			:currency => "NGN",
			)
		puts hash
		expect(hash.nil?).to eq false
		expect(hash['data']['id'].nil?).to eq false
		#expect(hash['message']).to eq "Recipient created"
	end


end