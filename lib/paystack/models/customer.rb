require 'paystack/models/base.rb'

class PaystackCustomer < PaystackBaseObject
	def create(data={})
		return PaystackCustomer.create(@paystack, data)
	end

	def get(customer_id)
		return PaystackCustomer.get(@paystack, customer_id)
	end


	def update(customer_id, data={})
		return PaystackCustomer.update(@paystack, customer_id,  data)
	end

	def list(page=1)
		return PaystackCustomer.list(@paystack, page)
	end


	def PaystackCustomer.create(paystackObj, data)
		initPostRequest(paystackObj,"#{API::CUSTOMER_PATH}/create",  data)
	end

	def PaystackCustomer.update(paystackObj, customer_id, data)
		initPutRequest(paystackObj,"#{API::CUSTOMER_PATH}/#{customer_id}",  data)
	end

	def PaystackCustomer.get(paystackObj, customer_id)
		initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}/#{customer_id}")
	end

	def PaystackCustomer.get(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}?page=#{page}")
	end
end
