require 'rest-client'
require 'paystack/crypto.rb'
require 'paystack/api.rb'
require 'paystack/card.rb'

module TokenManager

	CONCATENATOR = '*'
	RSA_PUBLIC_KEY = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANIsL+RHqfkBiKGn/D1y1QnNrMkKzxWP2wkeSokw2OJrCI+d6YGJPrHHx+nmb/Qn885/R01Gw6d7M824qofmCvkCAwEAAQ=="
	
	def TokenManager.create(card, publishableKey)
		card_str = concatCardFields(card)
		enc_card_str = Crypto.encrypt_string card_str, RSA_PUBLIC_KEY
		return createServerToken enc_card_str, publishableKey
	end

	

	def concatCardFields(card)
		raise PayStackCardError, 'Invalid Card' unless (!card.nil? && card.instanceof?(Card)) 

		number = Utils.nullifyString(card.number)
		cvc = card.cvc
		expiryMonth = card.expiryMonth
		expiryYear = card.expiryYear
		
		raise PayStackCardError, 'Card number cannot be empty or null' unless (!number.nil?)

		return "#{number}#{CONCATENATOR}#{cvc}#{CONCATENATOR}#{expiryMonth}#{CONCATENATOR}#{expiryYear}"

	end

	def createServerToken(encrypted_card, publishableKey)
		data = {:clientdata => encrypted_card, :publishableKey => publishableKey}
		token = nil;
		begin
			response = RestClient.post "#{API.BASE_URL}#{API.TOKEN_URL}", data.to_json, :content_type => :json, :accept => :json
			unless (response.code == 200 || response.code == 201)
					throw PayStackServerError, "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != 0 )
				throw PayStackServerError, "Server Message: #{result['message']}"
			end
			token = {:token => result['token'], :last4 => result['last4']}
		rescue JSON::ParserError => jsonerr
			throw PayStackServerError , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue => e
			Utils.serverErrorHandler(e)
		end
		return token

	end
end

