require 'paystack/objects/base.rb'

class PaystackCustomers < PaystackBaseObject
	def create(data={})
		return PaystackCustomers.create(@paystack, data)
	end

	def get(customer_id)
		return PaystackCustomers.get(@paystack, customer_id)
	end


	def update(customer_id, data={})
		return PaystackCustomers.update(@paystack, customer_id,  data)
	end

	def list(page=1)
		return PaystackCustomers.list(@paystack, page)
	end


	def PaystackCustomers.create(paystackObj, data)
		initPostRequest(paystackObj,"#{API::CUSTOMER_PATH}/create",  data)
	end

	def PaystackCustomers.update(paystackObj, customer_id, data)
		initPutRequest(paystackObj,"#{API::CUSTOMER_PATH}/#{customer_id}",  data)
	end

	def PaystackCustomers.get(paystackObj, customer_id)
		initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}/#{customer_id}")
	end

	def PaystackCustomers.get(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}?page=#{page}")
	end
end
