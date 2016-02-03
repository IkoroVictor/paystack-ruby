require 'paystack/utils.rb'

class Card
	attr_reader :name, :number,:cvc,:expiryMonth,:expiryYear, :addressLine1,:addressLine2, :addressLine3, :addressLine4, :addressCountry, :addressPostalCode, :email, :cardCountry, :cardIssuer

	MAX_DINERS_CARD_LENGTH  = 14
	MAX_AMERICAN_EXPRESS_CARD_LENGTH  = 15
	MAX_NORMAL_CARD_LENGTH  = 16

	PATTERN_VISA = /^4[0-9]{6,}$/                             
	PATTERN_MASTERCARD = /^5[1-5][0-9]{5,}$/                  
	PATTERN_AMERICAN_EXPRESS = /^3[47][0-9]{5,}$/             
	PATTERN_DINERS_CLUB = /^3(?:0[0-5]|[68][0-9])[0-9]{4,}$/ 
	PATTERN_DISCOVER = /^6(?:011|5[0-9]{2})[0-9]{3,}$/       
	PATTERN_JCB = /^(?:2131|1800|35[0-9]{3})[0-9]{3,}/       
	
	def initialize(*args)
		@name = Utils.nullifyString(args[:name])
		@number = Utils.nullifyString(args[:number])
		@cvc = Utils.nullifyString(args[:cvc])
		@expiryMonth =  Utils.nullifyString(args[:expiryMonth])
		@expiryYear = Utils.nullifyString(args[:expiryYear])
		@cardIssuer = Card.getCardType(@number)
	end

	def isValidCard()
    	if (@cvc != nil) 
      		return isValidNumber() && isValidExpiryDate() && isValidCVC()
    	else 
      		return isValidNumber() && isValidExpiryDate()
      	end
    
	end

	def Card.getCardType(number)
		if(number == nil)
			return 'invalid'
		end
		if(number =~ PATTERN_VISA) != nil
			return 'visa'
		end

		if(number =~ PATTERN_MASTERCARD) != nil
			return 'mastercard'
		end

		if(number =~ PATTERN_AMERICAN_EXPRESS) != nil
			return 'american_express'
		end

		if(number =~ PATTERN_DINERS_CLUB)
			return 'diners'
		end
		if(number =~ PATTERN_DISCOVER)
			return 'discover'
		end
		if(number =~ PATTERN_JCB)
			return 'jcb'
		end
		return 'unknown'		
	end




	

	def isValidNumber
		if(Utils.isEmpty(@number)) 
			return false
		end
		formatted_number = @number.gsub!(/\s+|-/).strip
		if(Utils.isEmpty(formatted_number) || !Utils.isWholePositiveNumber(formatted_number) || !Utils.isLuthValidNumber(formatted_number))
			return false
		end
		if Card.getCardType(formatted_number).eq('diners') 
			return (formatted_number.length == MAX_DINERS_CARD_LENGTH)
		end

		if Card.getCardType(formatted_number).eq('american_express') 
			return (formatted_number.length == MAX_AMERICAN_EXPRESS_CARD_LENGTH)
		end

		return (formatted_number.length == MAX_NORMAL_CARD_LENGTH)

	end

	def isValidCVC
		if(@cvc.eq(""))
			return false
		end
		cvc = @cvc.strip
		cvc_len = cvc.length

		validLength = ((cvc_len >= 3 && cvc_len <= 4) || (@cardIssuer.eq('american_express') && cvc_len == 4) ||(!@cardIssuer.eq('american_express') && cvc_len == 3))

	end

	def isValidExpireDate()
		return !(@expiryMonth == nil || @expiryYear == nil) && Utils.hasCardExpired(@expiryYear, @expiryMonth);
	end


end