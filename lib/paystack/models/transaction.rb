class PaystackTransaction
	attr_reader :paystack

	def initialize(paystackObj)
		unless !paystackObj.nil?
			raise ArgumentError, "Paystack object cannot be nil!!"
		end
		@paystack = paystackObj
	end

	def list(page=0)
		return PaystackTransaction.list(@paystack, page)
	end

	def get(transaction_id)
		return PaystackTransaction.get(@paystack, transaction_id)
	end


	def verify transaction_reference
		return PaystackTransaction.verify(@paystack, transaction_reference)
	end

	def  totals page=0
		return PaystackTransaction.totals(@paystack, page)
	end


# => Public Static methods
	def PaystackTransaction.list(paystackObj, page=0)
		
		initGetRequest(paystackObj, "?page=#{page}")
	end

	def PaystackTransaction.get(paystackObj, transaction_id)
	 	initGetRequest(paystackObj, "/#{transaction_id}")
	end


	def PaystackTransaction.verify(paystackObj, transaction_reference)
		initGetRequest(paystackObj, "/verify/#{transaction_reference}")
	end

	def PaystackTransaction.totals(paystackObj, page=0)
		initGetRequest(paystackObj, "/totals?page=#{page}")
	end

# => Private Static methods
	private

	def PaystackTransaction.initGetRequest(paystackObj, url) 
		result = nil
		begin
			response =  RestClient.get "#{API::BASE_URL}#{API::TRANSACTION_PATH}#{url}" , :Authorization  => "Bearer #{paystackObj.private_key}", :content_type => :json, :accept => :json
			unless (response.code == 200 || response.code == 201)
					raise PayStackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				raise PayStackServerError.new(response), "Server Message: #{result['message']}"
			end

		rescue JSON::ParserError => jsonerr
			raise PayStackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue PayStackServerError => e
			Utils.serverErrorHandler(e)
		end	
		return result
	end 

end
