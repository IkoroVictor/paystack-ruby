require 'paystack/objects/base.rb'

class PaystackSubaccounts < PaystackBaseObject
	def create(data={})
		return PaystackSubaccounts.create(@paystack, data)
	end

	def get(subaccount_id)
		return PaystackSubaccounts.get(@paystack, subaccount_id)
	end


	def update(subaccount_id, data={})
		return PaystackSubaccounts.update(@paystack, subaccount_id,  data)
	end

	def list(page=1)
		return PaystackSubaccounts.list(@paystack, page)
	end


	def PaystackSubaccounts.create(paystackObj, data)
		initPostRequest(paystackObj,"#{API::SUBACCOUNT_PATH}",  data)
	end

	def PaystackSubaccounts.update(paystackObj, subaccount_id, data)
		initPutRequest(paystackObj,"#{API::SUBACCOUNT_PATH}/#{subaccount_id}",  data)
	end

	def PaystackSubaccounts.get(paystackObj, subaccount_id)
		initGetRequest(paystackObj, "#{API::SUBACCOUNT_PATH}/#{subaccount_id}")
	end

	def PaystackSubaccounts.list(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::SUBACCOUNT_PATH}?page=#{page}")
	end
end
