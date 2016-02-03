
class PayStackServerError < StandardError
	attr_reader: response 
	def initialize(response=nil)
		@response = response
	end
end

class PayStackCardError < StandardError
end