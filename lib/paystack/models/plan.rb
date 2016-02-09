require 'paystack/models/base.rb'

class PaystackPlan < PaystackBaseObject	

	def create(data={})
		return PaystackPlan.create(@paystack, data)
	end

	def get(plan_id)
		return PaystackPlan.get(@paystack, plan_id)
	end


	def update(plan_id, data={})
		return PaystackPlan.update(@paystack, plan_id,  data)
	end

	def list(page=1)
		return PaystackPlan.list(@paystack, page)
	end


	def PaystackPlan.create(paystackObj, data)
		initPostRequest(paystackObj,"#{API::PLAN_PATH}/create",  data)
	end

	def PaystackPlan.update(paystackObj, plan_id, data)
		initPutRequest(paystackObj,"#{API::PLAN_PATH}/#{plan_id}",  data)
	end

	def PaystackPlan.get(paystackObj, plan_id)
		initGetRequest(paystackObj, "#{API::PLAN_PATH}/#{plan_id}")
	end

	def PaystackPlan.get(paystackObj, page=1)
		initGetRequest(paystackObj, "#{API::PLAN_PATH}?page=#{page}")
	end




end