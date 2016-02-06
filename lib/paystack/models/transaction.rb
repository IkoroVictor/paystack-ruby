class PaystackTransaction
	attr_reader :paystack

	def initialize(paystackObj)
		unless paystackObj.nil?
			raise ArgumentError, "Paystack object cannot be nil!!"
		end
		@paystack = paystackObj
	end






	def PaystackTransaction.list(paystackObj, page=0)
	end

	def PaystackTransaction.get(paystackObj, transaction_id)
	end

	def 

end
