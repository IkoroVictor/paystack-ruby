require 'rest-client'
require 'paystack/modules/crypto.rb'
require 'paystack/modules/api.rb'
require 'paystack/models/card.rb'

module TokenManager

	CONCATENATOR = '*'
	RSA_PUBLIC_KEY = "-----BEGIN PUBLIC KEY-----\nMFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANIsL+RHqfkBiKGn/D1y1QnNrMkKzxWP\n2wkeSokw2OJrCI+d6YGJPrHHx+nmb/Qn885/R01Gw6d7M824qofmCvkCAwEAAQ==\n-----END PUBLIC KEY-----\n"
	
	def TokenManager.create(card, publishableKey)
		if(card == nil)
			raise PayStackCardError, "Card cannot be null"
		elsif !card.isValidCard()
			raise PayStackCardError, "Invalid card details"
		end
				
		card_str = concatCardFields(card)
		enc_card_str = Crypto.encrypt_string(card_str, RSA_PUBLIC_KEY)
		return createServerToken enc_card_str, publishableKey
	end	

	def TokenManager.concatCardFields(card)
		raise PayStackCardError, 'Invalid Card' unless (!card.nil? && card.instance_of?(PaystackCard)) 

		number = Utils.nullifyString(card.number)
		cvc = card.cvc
		expiryMonth = card.expiryMonth
		expiryYear = card.expiryYear
		
		raise PayStackCardError, 'Card number cannot be empty or null' unless (!number.nil?)

		return "#{number}#{CONCATENATOR}#{cvc}#{CONCATENATOR}#{expiryMonth}#{CONCATENATOR}#{expiryYear}"

	end

	def TokenManager.createServerToken(encrypted_card, publishableKey)
		token = nil;
		begin
			response = RestClient.post "#{API::BASE_URL}#{API::TOKEN_URL}", :clientdata => encrypted_card, :publishablekey => publishableKey 
			unless (response.code == 200 || response.code == 201)
					raise PayStackServerError.new(response), "HTTP Code #{response.code}: #{response.body}"
			end
			result = JSON.parse(response.body)
			unless(result['status'] != '0' )
				raise PayStackServerError.new(response), "Server Message: #{result['message']}"
			end
			token = {:token => result['token'], :last4 => result['last4']}
		rescue JSON::ParserError => jsonerr
			raise PayStackServerError.new(response) , "Invalid result data. Could not parse JSON response body \n #{jsonerr.message}"

		rescue PayStackServerError => e
			puts e.response.code
			Utils.serverErrorHandler(e)
		end
		return token

	end
end

