class PaystackBaseObject

	attr_reader :paystack

	def initialize(paystackObj)
		raise ArgumentError, "Paystack object cannot be nil!!" unless paystackObj
		@paystack = paystackObj
	end

	def self.initGetRequest(paystackObj, url)
		response =  RestClient.get(
			"#{API::BASE_URL}#{url}" ,
			Authorization: "Bearer #{paystackObj.private_key}",
			content_type: :json,
			accept: :json
		)
		raise_error_or_return_result(response)
	end

	def self.initPostRequest(paystackObj, url, data = {}, json=false )
		if !json
			response =  RestClient.post("#{API::BASE_URL}#{url}",
			 	data,
				Authorization: "Bearer #{paystackObj.private_key}"
			)
		else
			response =  RestClient.post(
				"#{API::BASE_URL}#{url}" ,
				data.to_json,
				:Authorization  => "Bearer #{paystackObj.private_key}",
				:content_type => :json,
				:accept => :json
			)
		end
		raise_error_or_return_result(response)
	end

	def self.initPutRequest(paystackObj, url, data = {} )
		response =  RestClient.put(
			"#{API::BASE_URL}#{url}",
			 data,
			 Authorization: "Bearer #{paystackObj.private_key}"
		)
		raise_error_or_return_result(response)
	end

	def self.initDeleteRequest(paystackObj, url)
		response =  RestClient.delete(
			"#{API::BASE_URL}#{url}" ,
			Authorization: "Bearer #{paystackObj.private_key}"
		)
		raise_error_or_return_result(response)
	end

	private

	def self.raise_error_or_return_result(response)
		unless (response.code == 200 || response.code == 201)
				raise(
					PaystackServerError.new(response),
					"HTTP Code #{response.code}: #{response.body}"
				)
		end
		result = JSON.parse(response.body)
		unless(result['status'] != 0 )
			raise(
				PaystackServerError.new(response),
				"Server Message: #{result['message']}"
			)
		end

		return result
		rescue JSON::ParserError => jsonerr
			raise(
				PaystackServerError.new(response),
				"Invalid result data. Could not parse JSON response "\
				"body \n #{jsonerr.message}"
			)

		rescue PaystackServerError => e
			Utils.serverErrorHandler(e)
	end
end
