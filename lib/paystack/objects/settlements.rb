require 'paystack/objects/base.rb'

class PaystackSettlements < PaystackBaseObject
	def list(data={})
		return PaystackBanks.list(@paystack, data)
	end


	def PaystackSettlements.list(paystackObj, data={})
		initGetRequest(paystackObj, "#{API::SETTLEMENT_PATH}",data)
	end
end
