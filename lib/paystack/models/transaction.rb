require 'paystack/models/base.rb'

class PaystackTransaction < PaystackBaseObject
	
	def list(page=1)
		return PaystackTransaction.list(@paystack, page)
	end

	def get(transaction_id)
		return PaystackTransaction.get(@paystack, transaction_id)
	end


	def verify transaction_reference
		return PaystackTransaction.verify(@paystack, transaction_reference)
	end

	def  totals page=1
		return PaystackTransaction.totals(@paystack, page)
	end


# => Public Static methods
	def PaystackTransaction.list(paystackObj, page=1)
		
		initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}?page=#{page}")
	end

	def PaystackTransaction.get(paystackObj, transaction_id)
	 	initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}/#{transaction_id}")
	end


	def PaystackTransaction.verify(paystackObj, transaction_reference)
		initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}/verify/#{transaction_reference}")
	end

	def PaystackTransaction.totals(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}/totals?page=#{page}")
	end

 

end
