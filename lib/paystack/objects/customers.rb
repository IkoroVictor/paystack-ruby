require 'paystack/objects/base.rb'

class PaystackCustomers < PaystackBaseObject
	def create(data={})
		PaystackCustomers.create(paystack, data)
	end

	def get(customer_id)
		PaystackCustomers.get(paystack, customer_id)
	end

	def update(customer_id, data={})
		PaystackCustomers.update(paystack, customer_id,  data)
	end

	def list(page=1)
		PaystackCustomers.list(paystack, page)
	end

protected
	def self.create(paystack, data)
		initPostRequest(paystack, "#{API::CUSTOMER_PATH}", data)
	end

	def self.update(paystack, customer_id, data)
		initPutRequest(paystack, "#{API::CUSTOMER_PATH}/#{customer_id}",  data)
	end

	def self.get(paystack, customer_id)
		initGetRequest(paystack, "#{API::CUSTOMER_PATH}/#{customer_id}")
	end

	def self.list(paystack, page=1)
		initGetRequest(paystack, "#{API::CUSTOMER_PATH}?page=#{page}")
	end

	def self.paystack_whitelist_or_blacklist(paystack, data)
		initPostRequest(paystack, "#{API::CUSTOMER_PATH}/set_risk_action", data, true)
	end
end
