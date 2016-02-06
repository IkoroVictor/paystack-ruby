require 'rest-client'
require 'paystack/modules/tokenmanager.rb'
require 'paystack/error.rb'
require 'paystack/utils/utils.rb'


class Paystack
	attr_reader :public_key, :private_key

	def initialize paystack_public_key=nil, paystack_private_key=nil
		if(paystack_public_key.nil?)
			@public_key = ENV['PAYSTACK_PUBLIC_KEY']
		else
			@public_key = paystack_public_key
		end

		if(paystack_private_key.nil?)
			@private_key = ENV['PAYSTACK_PRIVATE_KEY']
		else
			@private_key = paystack_private_key
		end
	end

	def getToken card
		return TokenManager.create(card, @public_key)
	end

	def setPublicKey public_key
		@public_key = public_key
	end

	def setPrivateKey public_key
		@public_key = public_key
	end

	def chargeToken(token, amount,args = {})
		token = token;
		amount = amount
		email = args[:email]
		reference = args[:reference]
		result = nil;
		
		begin
			response =  RestClient.post API::CHARGE_TOKEN_URL, {:token => token, :amount => amount, :email => email, :reference => reference}.to_json, :Authorization  => "Bearer #{@private_key}", :content_type => :json, :accept => :json
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
