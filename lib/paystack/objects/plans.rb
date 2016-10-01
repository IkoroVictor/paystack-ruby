require 'paystack/objects/base.rb'

class PaystackPlans < PaystackBaseObject	

	def create(data={})
		return PaystackPlans.create(@paystack, data)
	end

	def get(plan_id)
		return PaystackPlans.get(@paystack, plan_id)
	end


	def update(plan_id, data={})
		return PaystackPlans.update(@paystack, plan_id,  data)
	end

	def list(page=1)
		return PaystackPlans.list(@paystack, page)
	end


	def PaystackPlans.create(paystackObj, data)
		initPostRequest(paystackObj,"#{API::PLAN_PATH}",  data)
	end

	def PaystackPlans.update(paystackObj, plan_id, data)
		initPutRequest(paystackObj,"#{API::PLAN_PATH}/#{plan_id}",  data)
	end

	def PaystackPlans.get(paystackObj, plan_id)
		initGetRequest(paystackObj, "#{API::PLAN_PATH}/#{plan_id}")
	end

	def PaystackPlans.list(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::PLAN_PATH}?page=#{page}")
	end


end