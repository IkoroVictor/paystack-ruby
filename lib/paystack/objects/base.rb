class PaystackBaseObject

	attr_reader :paystack

	def initialize(paystackObj)
		unless !paystackObj.nil?
			raise ArgumentError, "Paystack object cannot be nil!!"
		end
		@paystack = paystackObj
	end

	protected
	# =>Static methods
	def self.initGetRequest(paystackObj, url) 
		result = nil
		begin
			response =  RestClient.get "#{API::BASE_URL}#{url}" , :Authorization  => "Bearer #{paystackObj.private_key}", :content_type => :json, :accept => :json
			unless (response.code == 200 || response.code == 201)
					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
			end

		rescue JSON::ParserError => jsonerr
			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue PayStackServerError => e
			Utils.serverErrorHandler(e)
		end	
		return result
	end

	def self.initPostRequest(paystackObj, url, data = {}, json=false ) 
		result = nil
		begin
			if !json
				response =  RestClient.post "#{API::BASE_URL}#{url}" , data,  :Authorization  => "Bearer #{paystackObj.private_key}"
			else
				response =  RestClient.post "#{API::BASE_URL}#{url}" , data.to_json,  :Authorization  => "Bearer #{paystackObj.private_key}", :content_type => :json, :accept => :json
		
			end
			unless (response.code == 200 || response.code == 201)
					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
			end

		rescue JSON::ParserError => jsonerr
			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue PayStackServerError => e
			Utils.serverErrorHandler(e)
		end	
		return result
	end

	def self.initPutRequest(paystackObj, url, data = {} ) 
		result = nil
		begin
			response =  RestClient.put "#{API::BASE_URL}#{url}" , data,  :Authorization  => "Bearer #{paystackObj.private_key}"
			unless (response.code == 200 || response.code == 201)
					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
			end

		rescue JSON::ParserError => jsonerr
			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue PayStackServerError => e
			Utils.serverErrorHandler(e)
		end	
		return result
	end

	def self.initDeleteRequest(paystackObj, url) 
		result = nil
		begin
			response =  RestClient.delete "#{API::BASE_URL}#{url}" ,  :Authorization  => "Bearer #{paystackObj.private_key}"
			unless (response.code == 200 || response.code == 201)
					raise PaystackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				raise PaystackServerError.new(response), "Server Message: #{result['message']}"
			end

		rescue JSON::ParserError => jsonerr
			raise PaystackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue PayStackServerError => e
			Utils.serverErrorHandler(e)
		end	
		return result
	end
end
