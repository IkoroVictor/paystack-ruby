require 'spec_helper'
require 'paystack/objects/transfers.rb'
require 'paystack.rb'

public_test_key = "pk_test_ea7c71f838c766922873f1dd3cc529afe13da1c0"
private_test_key = "sk_test_40e9340686e6187697f8309dbae57c002bb16dd0"

describe PaystackTransfers do
	it "should return a valid transfer object" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfers = PaystackTransfers.new(paystack)
		expect(transfers.nil?).to eq false
	end

	it "should initialize a transfer and expect a transfer code" do
		recipient_code = "RCP_213xswghvej0gzv" #manually generated recipient code to avoid errors
		paystack = Paystack.new(public_test_key, private_test_key)
		transfers = PaystackTransfers.new(paystack)
		expect(transfers.nil?).to eq false
		temp = transfers.initializeTransfer(
			:source => "balance",
			:reason => "Keep the change",
			:amount => 30000, # amount in kobo
			:recipient =>  recipient_code,
			)
		#puts temp
		expect(temp.nil?).to eq false
		expect(temp['data']['transfer_code'].nil?).to eq false

	end

	it "should return a list of transfers" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfers = PaystackTransfers.new(paystack)
		expect(transfers.nil?).to eq false
		list =  transfers.list(1)
		#puts list
		expect(list.nil?).to eq false
	end

	it "should return a valid transfer hashset" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfers = PaystackTransfers.new(paystack)
		expect(transfers.nil?).to eq false
		list =  transfers.list(1)
		expect(list.nil?).to eq false
		temp = list["data"][0]
		#puts temp["transfer_code"]
		hash = transfers.get(temp["transfer_code"])
		expect(hash.nil?).to eq false
		expect(hash['data']['transfer_code']).to eq temp["transfer_code"]
  end

	it "verify should return a valid transfer hashset" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfers = PaystackTransfers.new(paystack)
		expect(transfers.nil?).to eq false
		list =  transfers.list(1)
		expect(list.nil?).to eq false
		temp = list["data"][0]
		hash = transfers.verify(temp["reference"])
		expect(hash.nil?).to eq false
		expect(hash['data']['verify']).to eq temp["verify"]
	end

	it "should resend OTP to authorize a transfer" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfers = PaystackTransfers.new(paystack)
		expect(transfers.nil?).to eq false
		list =  transfers.list(1)
		expect(list.nil?).to eq false
		temp = list["data"][0]
		hash = transfers.resendOtp(temp["transfer_code"])
		expect(hash.nil?).to eq false
	end

	it "should disable OTP for transfers" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfer = PaystackTransfers.new(paystack)
		expect(transfer.nil?).to eq false
		hash = transfer.disableOtp
		#puts totals
		expect(hash.nil?).to eq false
	end

	it "should enable OTP for transfers" do
		paystack = Paystack.new(public_test_key, private_test_key)
		transfer = PaystackTransfers.new(paystack)
		expect(transfer.nil?).to eq false
		hash = transfer.enableOtp
		#puts totals
		expect(hash.nil?).to eq false
	end



end