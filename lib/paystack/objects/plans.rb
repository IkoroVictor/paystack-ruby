require 'paystack/objects/base.rb'

class PaystackPlans < PaystackBaseObject

	def create(data={})
		PaystackPlans.create(paystack, data)
	end

	def get(plan_id)
		PaystackPlans.get(paystack, plan_id)
	end


	def update(plan_id, data={})
		PaystackPlans.update(paystack, plan_id,  data)
	end

	def list(page=1)
		PaystackPlans.list(paystack, page)
	end

protected
	def self.create(paystack, data)
		initPostRequest(paystack, "#{API::PLAN_PATH}",  data)
	end

	def self.update(paystack, plan_id, data)
		initPutRequest(paystack, "#{API::PLAN_PATH}/#{plan_id}",  data)
	end

	def self.get(paystack, plan_id)
		initGetRequest(paystack, "#{API::PLAN_PATH}/#{plan_id}")
	end

	def self.list(paystack, paystackObj, page=1)
		initGetRequest(paystack, "#{API::PLAN_PATH}?page=#{page}")
	end
end
