require 'paystack/objects/base.rb'

class PaystackBalance < PaystackBaseObject
	def get
		return PaystackBalance.get(@paystack)
	end


	def PaystackBalance.get(paystackObj)
		initGetRequest(paystackObj, "#{API::BALANCE_PATH}")
	end
end
