
require 'paystack/error.rb'

module Utils
	
	def Utils.nullifyString(value)
		if value.nil?
			return nil
		end

		if (value.strip.eql? "")
			return nil
		end
		return value;
	end

	def Utils.isWholePositiveNumber(value)
		if(value == nil)
			return false
		end
		length = value.length;

		for i in 0..(length-1)
			c = value[i]

			if((c =~ /[[:digit:]]/) == nil)
				return false
			end
		end
		return true
	end

	def Utils.isLuhnValidNumber(number)
		sum = 0
		length = number.strip.length;

		for i in 0..(length-1)
			c = number[length - 1 -i]

			if((c =~ /[[:digit:]]/) == nil)
				return false
			end
			digit = c.to_i
			if (i % 2 == 1)
				digit *= 2
			end 
			sum += digit > 9 ? digit - 9 : digit
		end

		return (sum % 10 == 0)
	end

	def Utils.isEmpty(value)
		return (value.nil? || value.strip.eql?(""))
	end

	def Utils.hasYearPassed(year)
		return year < Time.new.year
	end
	def Utils.hasMonthPassed(year, month)
		t = Time.new
		return hasYearPassed(year) || year == t.year && month < (t.month)
	end

	def Utils.hasCardExpired(year, month)
		# Normalize Year value e.g 14 becomes 2014 or 2114  etc.
		year_int = year.strip.to_i
		if(year_int < 100 && year_int >= 0)
			cal_year = Time.new.year.to_s
			year_int = ("#{cal_year[0..1]}#{year.strip}").to_i
		end
		
		# Check for expiration
		return !hasYearPassed(year_int) && !hasMonthPassed(year_int, month.to_i)

	end

	



	def Utils.serverErrorHandler(e)

		if(e.response == nil)
			raise e
			return
		end
		error = PaystackServerError.new(e.response);
		case e.response.code
				when 400
					raise error, "HTTP Code 400: A validation or client side error occurred and the request was not fulfilled. "
				when 401
					raise error, "HTTP Code 401: The request was not authorized. This can be triggered by passing an invalid secret key in the authorization header or the lack of one"
				when 404
					raise error, "HTTP Code 404: Request could not be fulfilled as the request resource does not exist."
				when 500, 501,502,503,504
					raise error, "HTTP Code #{e.response.code}: Request could not be fulfilled due to an error on Paystack's end. This shouldn't happen so please report as soon as you encounter any instance of this."
				else
					raise error, "HTTP Code #{e.response.code}: #{e.response.body}"
					
				end

	end

end
