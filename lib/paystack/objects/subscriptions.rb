require 'paystack/objects/base.rb'


class PaystackSubscriptions < PaystackBaseObject

  def create(data={})
    return PaystackSubscriptions.create(@paystack, data)
  end

  def get(subscription_id)
    return PaystackSubscriptions.get(@paystack, subscription_id)
  end

  def disable(data={})
    return PaystackSubscriptions.disable(@paystack, data)
  end

  def enable(data={})
    return PaystackSubscriptions.enable(@paystack, data)
  end


  def PaystackSubscriptions.create(paystackObj, data)
    initPostRequest(paystackObj, "#{API::SUBSCRIPTION_PATH}", data)
  end

  def PaystackSubscriptions.get(paystackObj, subscription_id)
    initGetRequest(paystackObj, "#{API::SUBSCRIPTION_PATH}/#{subscription_id}")
  end

  def PaystackSubscriptions.enable(paystackObj, data={})
    initPostRequest(paystackObj, "#{API::SUBSCRIPTION_PATH}/enable", data)
  end

  def PaystackSubscriptions.disable(paystackObj, data)
    initPostRequest(paystackObj, "#{API::SUBSCRIPTION_PATH}/disable", data)
  end


end