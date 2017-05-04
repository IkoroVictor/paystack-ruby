require 'paystack/objects/base.rb'

class PaystackSettlements < PaystackBaseObject
	def list
		return PaystackSettlements.list(@paystack)
	end


	def PaystackSettlements.list(paystackObj)
		initGetRequest(paystackObj, "#{API::SETTLEMENT_PATH}")
	end
end
