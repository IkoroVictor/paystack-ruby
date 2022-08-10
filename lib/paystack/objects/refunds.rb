require 'paystack/objects/base.rb'

class PaystackRefunds < PaystackBaseObject

  def createRefund(args={})
    return PaystackRefunds.createRefund(@paystack, args)
  end

  def list(page=1)
    return PaystackRefunds.list(@paystack, page)
  end

  def get(refund_id)
    return PaystackRefunds.get(@paystack, refund_id)
  end

# => Public Static methods
  def PaystackRefunds.createRefund(paystackObj, args)
    initPostRequest(paystackObj,"#{API::REFUND_PATH}", args,true)
  end

  def PaystackRefunds.list(paystackObj, page=1)
    initGetRequest(paystackObj, "#{API::REFUND_PATH}?page=#{page}")
  end

  def PaystackRefunds.get(paystackObj, refund_id)
    initGetRequest(paystackObj, "#{API::REFUND_PATH}/#{refund_id}")
  end
end
