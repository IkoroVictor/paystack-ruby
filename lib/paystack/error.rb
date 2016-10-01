class PaystackServerError < StandardError
	attr_reader :response 
	def initialize(response=nil)
		@response = response
	end
end

class PaystackCardError < StandardError
end

class PaystackBadKeyError < StandardError
end