require 'paystack/objects/base.rb'


class PaystackRecipients < PaystackBaseObject

  def create(data={})
    return PaystackRecipients.create(@paystack, data)
  end

  def list(page=1)
    return PaystackRecipients.list(@paystack, page)
  end


  def PaystackRecipients.create(paystackObj, data)
    initPostRequest(paystackObj, "#{API::RECIPIENT_PATH}", data)
  end

  def PaystackRecipients.list(paystackObj, page=1)
    initGetRequest(paystackObj, "#{API::RECIPIENT_PATH}/?page=#{page}")
  end




end