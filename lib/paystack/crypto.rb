require "Base64"
require "openssl"

module Crypto

	def Crypto.encrypt_string(message, public_key)
		
		rsa = OpenSSL::PKey::RSA.new public_key
		return Base64::encode64(rsa.public_encrypt(message)).rstrip
	end
end
