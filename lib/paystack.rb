require 'rest-client'
require 'paystack/tokenmanager.rb'
require 'paystack/error.rb'
require 'paystack/utils.rb'


class Paystack
	attr_reader :public_key

	def initialize paystack_public_key=nil
		if(paystack_public_key.nil?)
			@public_key = ENV['PAYSTACK_PUBLIC_KEY']
		else
			@public_key = paystack_public_key
		end
	end

	def getToken card
		return TokenManager.create(card, @public_key)
	end

	def setPublicKey public_key
		@public_key = public_key
	end

	def chargeToken(token, amount, *args)
		token = token;
		amount = amount
		email = args[:email]
		reference = args[:reference]
		result = nil;
		
		begin
			response =  RestClient.post API.CHARGE_TOKEN_URL, {:token => token, :amount => amount, :email => email, :reference => reference}
			unless (response.code == 200 || response.code == 201)
					throw PayStackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				throw PayStackServerError.new(response), "Server Message: #{result['message']}"
			end

		rescue JSON::ParserError => jsonerr
			throw PayStackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue => e
			if(e.response.nil?)
				throw e
				return
			end
			Utils.serverErrorHandler(e)
		end	
		return result
	end

end
