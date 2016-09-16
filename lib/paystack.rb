require 'rest-client'
require 'paystack/error.rb'
require 'paystack/modules/api.rb'
require 'paystack/utils/utils.rb'
require 'paystack/objects/card.rb'
require 'paystack/objects/customers.rb'
require 'paystack/objects/plans.rb'
require 'paystack/objects/transactions.rb'

class Paystack

	attr_accessor :public_key, :private_key

	def initialize(paystack_pbk_key = nil, paystack_pri_key = nil)
		@public_key = paystack_pbk_key ? paystack_pbk_key : ENV['PAYSTACK_PUBLIC_KEY']
		@private_key = paystack_pri_key ? paystack_pri_key : ENV['PAYSTACK_PRIVATE_KEY']
		check_keys
		check_keys(false)
	end

	private

	def check_keys(pbk_key = true)
		key, key_starter = pbk_key ? [public_key, "pk_"] : [private_key, "sk_"]
		key_to_string = pbk_key ? "public key" : "private key"
		unless key
			raise(
			PaystackBadKeyError,
			"No #{key_to_string} supplied and couldn't find any in "\
			"environment variables. Make sure to set public key as an "\
			"environment variable PAYSTACK_PUBLIC_KEY"
			)
		end
		unless key[0..2] == key_starter
			raise PaystackBadKeyError, "Invalid #{key_starter} #{public_key}"
		end
	end
end
