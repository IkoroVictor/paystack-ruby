require 'paystack/objects/base.rb'

class PaystackTransfers < PaystackBaseObject
	
	def initializeTransfer(args={})
		return PaystackTransfers.initializeTransfer(@paystack, args)
	end

	def list(page=1)
		return PaystackTransfers.list(@paystack, page)
	end

	def get(transfer_code)
		return PaystackTransfers.get(@paystack, transfer_code)
	end

	def authorize(data={})
		return PaystackTransfers.authorize(@paystack,data)
	end

	def  resendOtp(transfer_code)
		return PaystackTransfers.resendOtp(@paystack)
	end

	def  disableOtp 
		return PaystackTransfers.disableOtp(@paystack)
	end

	def  confirmDisableOtp(otp)
		return PaystackTransfers.confirmDisableOTP(@paystack,otp)
	end

	def  enableOtp 
		return PaystackTransfers.enableOtp(@paystack)
	end

# => Public Static methods

	def PaystackTransfers.initializeTransfer(paystackObj, args)
		initPostRequest(paystackObj,"#{API::TRANSFER_PATH}", args,true)
	end

	def PaystackTransfers.list(paystackObj, page=1)		
		initGetRequest(paystackObj, "#{API::TRANSFER_PATH}?page=#{page}")
	end

	def PaystackTransfers.get(paystackObj, transfer_code)
	 	initGetRequest(paystackObj, "#{API::TRANSFER_PATH}/#{transfer_code}")
	end

	def PaystackTransfers.authorize(paystackObj, data={})
		initPostRequest(paystackObj, "#{API::TRANSFER_PATH}/finalize_transfer/",data)
	end

	def PaystackTransfers.resendOtp(paystackObj, transfer_code)
		initPostRequest(paystackObj, "#{API::TRANSFER_PATH}/resend_otp",transfer_code)
	end

	def PaystackTransfers.disableOtp(paystackObj)
		initPostRequest(paystackObj, "#{API::TRANSFER_PATH}/disable_otp")
	end

	def PaystackTransfers.confirmDisableOtp(paystackObj, otp)
		initPostRequest(paystackObj, "#{API::TRANSFER_PATH}/disable_otp_finalize",otp)
	end

	def PaystackTransfers.enableOtp(paystackObj)
		initPostRequest(paystackObj, "#{API::TRANSFER_PATH}/enable_otp")
	end



 

end
