require 'paystack/objects/base.rb'

class PaystackTransactions < PaystackBaseObject
	
	def list(page=1)
		return PaystackTransactions.list(@paystack, page)
	end

	def get(transaction_id)
		return PaystackTransactions.get(@paystack, transaction_id)
	end


	def verify transaction_reference
		return PaystackTransactions.verify(@paystack, transaction_reference)
	end

	def  totals page=1
		return PaystackTransactions.totals(@paystack, page)
	end


# => Public Static methods
	def PaystackTransactions.list(paystackObj, page=1)
		
		initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}?page=#{page}")
	end

	def PaystackTransactions.get(paystackObj, transaction_id)
	 	initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}/#{transaction_id}")
	end


	def PaystackTransactions.verify(paystackObj, transaction_reference)
		initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}/verify/#{transaction_reference}")
	end

	def PaystackTransactions.totals(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::TRANSACTION_PATH}/totals?page=#{page}")
	end

 

end
