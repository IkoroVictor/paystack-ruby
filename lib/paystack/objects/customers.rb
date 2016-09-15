require 'paystack/objects/base.rb'

class PaystackCustomers < PaystackBaseObject
	def create(data={})
		PaystackCustomers.create(@paystack, data)
	end

	def get(customer_id)
		PaystackCustomers.get(@paystack, customer_id)
	end

	def update(customer_id, data={})
		PaystackCustomers.update(@paystack, customer_id,  data)
	end

	def list(page=1)
		PaystackCustomers.list(@paystack, page)
	end

protected
	def PaystackCustomers.create(paystackObj, data)
		initPostRequest(paystackObj,"#{API::CUSTOMER_PATH}",  data)
	end

	def PaystackCustomers.update(paystackObj, customer_id, data)
		initPutRequest(paystackObj,"#{API::CUSTOMER_PATH}/#{customer_id}",  data)
	end

	def PaystackCustomers.get(paystackObj, customer_id)
		initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}/#{customer_id}")
	end

	def PaystackCustomers.list(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}?page=#{page}")
	end
end
