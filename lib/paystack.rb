require 'rest-client'
require 'paystack/error.rb'
require 'paystack/modules/api.rb'
require 'paystack/utils/utils.rb'
require 'paystack/objects/card.rb'
require 'paystack/objects/customers.rb'
require 'paystack/objects/plans.rb'
require 'paystack/objects/subscriptions.rb'
require 'paystack/objects/transactions.rb'
require 'paystack/objects/banks.rb'
require 'paystack/objects/balance.rb'
require 'paystack/objects/settlements.rb'
require 'paystack/objects/recipients.rb'
require 'paystack/objects/transfers.rb'
require 'paystack/objects/subaccounts.rb'


class Paystack
  attr_reader :public_key, :private_key

  def initialize paystack_public_key=nil, paystack_private_key=nil
    if (paystack_public_key.nil?)
      @public_key = ENV['PAYSTACK_PUBLIC_KEY']
    else
      @public_key = paystack_public_key
    end

    if (paystack_private_key.nil?)
      @private_key = ENV['PAYSTACK_PRIVATE_KEY']
    else
      @private_key = paystack_private_key
    end

    unless !@public_key.nil?
      raise PaystackBadKeyError, "No public key supplied and couldn't find any in environment variables. Make sure to set public key as an environment variable PAYSTACK_PUBLIC_KEY"
    end
    unless @public_key[0..2] == 'pk_'
      raise PaystackBadKeyError, "Invalid public key #{@public_key}"
    end

    unless !@private_key.nil?
      raise PaystackBadKeyError, "No private key supplied and couldn't find any in environment variables. Make sure to set private key as an environment variable PAYSTACK_PRIVATE_KEY"
    end
    unless @private_key[0..2] == 'sk_'
      raise PaystackBadKeyError, "Invalid private key #{@private_key}"
    end
  end

  #TODO delete if not used
  def setPublicKey public_key
    @public_key = public_key
  end

  def setPrivateKey public_key
    @public_key = public_key
  end

end
