require 'paystack/objects/base.rb'

class PaystackBanks < PaystackBaseObject
	def list(page=1)
		return PaystackBanks.list(@paystack, page)
	end


	def PaystackBanks.list(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::BANK_PATH}?page=#{page}")
	end
end
