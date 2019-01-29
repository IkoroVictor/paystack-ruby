# Paystack

[![Build Status](https://travis-ci.org/IkoroVictor/paystack-ruby.svg?branch=master)](https://travis-ci.org/IkoroVictor/paystack-ruby) [![Gem Version](https://badge.fury.io/rb/paystack.svg)](https://badge.fury.io/rb/paystack)

A ruby gem for easy integration of [Paystack](https://paystack.co/).  


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paystack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paystack

## Basic Usage



### Instantiate Paystack Object

```ruby

    paystackObj = Paystack.new(public_key, secret_key)

```

A secure way is to set your public and private keys as environmental variables `PAYSTACK_PUBLIC_KEY` and `PAYSTACK_PRIVATE_KEY` respectively. Then you instantiate without parameters

```ruby

	paystackObj =  Paystack.new

```
It throws a `PaystackBadKeyError` when either of the keys are invalid or cannot be found as environment variables.



### Initialize transaction and get Authorization URL

```ruby

	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.initializeTransaction(
		:reference => "blablablabla-YOUR-UNIQUE-REFERENCE-HERE",
		:amount => 300000,
		:email => "xxxxxx@gmail.com",
		)
	auth_url = result['data']['authorization_url']
```
NOTE: Amount is in kobo i.e. `100000 = 100000 kobo = 1000 naira`



### Charge using Authorization code for returning customers

```ruby

	result = transactions.chargeAuthorization(
		"WwdkojpoAJo", 				# Authorization code
		"xxxxxx@gmail.com", 		# Customer email
		2000000, 					# Amount
		:reference => "blablablabla-YOUR-UNIQUE-REFERENCE-HERE"
		)
```



## Transactions



### List transactions

```ruby

	page_number = 1
	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.list(page_number) 	#Optional `page_number` parameter

```

### Get a transaction

```ruby

	transaction_id = "123456778"
	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.get(transaction_id)

```

### Verify a transaction

```ruby

	transaction_reference = "blablablabla-YOUR-VALID-UNIQUE-REFERENCE-HERE"
	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.verify(transaction_reference)

```


### Get transaction totals

```ruby

	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.totals()

```


## Customers


### List Customers

```ruby

	page_number = 1
	customers = PaystackCustomers.new(paystackObj)
	result = customers.list(page_number) 	#Optional `page_number` parameter,  50 items per page
	customers_list = result['data']

```

### Get a customer

```ruby

	customer_id = "123456778"
	customers = PaystackCustomers.new(paystackObj)
	result = customers.get(customer_id)
	customer =  result['data']

```

### Create new customer

```ruby

	customers = PaystackCustomers.new(paystackObj)
	result = customers.create(
		:first_name => "Victor",
		:last_name => "Ikoro",
		:phone => "+234707666669"
		:email => "xxxxx@gmail.com"
	)

```

### Update customer details

```ruby

	customer_id = "123456778"
	customers = PaystackCustomers.new(paystackObj)
	# Updating last name and email of customer
	result = customers.update(
		customer_id,
		:last_name => "Ikorodu",
		:email => "xxxxx-modified@gmail.com"
	)

```

## Plans

### List Plans

```ruby

	page_number = 1
	plans = PaystackPlans.new(paystackObj)
	result = plans.list(page_number) 	#Optional `page_number` parameter,  50 items per page
	plans_list = result['data']

```

### Get plan detail

```ruby

	plan_id = "123456778"
	plans = PaystackPlans.new(paystackObj)
	result = plans.get(plan_id)
	plan =  result['data']

```

### Create new plan

```ruby

	plans = PaystackPlans.new(paystackObj)
	result = plans.create(

				:name => "Test Plan",
				:description => "Dev Test Plan",
				:amount => 30000, #in KOBO
				:interval => "monthly", #monthly, yearly, quarterly, weekly etc
				:currency => "NGN"
			)

```

### Update plan details

```ruby

	plan_id = "123456778"
	plans = PaystackPlans.new(paystackObj)
	result = plans.update(
			plan_id,
			:name => "Test Plan Updated",
			:amount => 500000, #in KOBO
			:interval => "weekly"
			)

```


## Subscriptions

### Create new subscription

```ruby

	subscriptions = PaystackSubscriptions.new(paystackObj)
	result = subscriptions.create(

				:customer => "customer@email.com",
				:plan => "123557", #plan id
				:amount => 30000 #in KOBO
			)

```

### Get subscription detail

```ruby

	subscription_id = "123456778"
	subscriptions = PaystackSubscriptions.new(paystackObj)
	result = subscriptions.get(subscription_id)
	subscription =  result['data']

```

### Enable subscription

```ruby

	subscriptions = PaystackSubscriptions.new(paystackObj)
	result = subscriptions.enable(
				:code => "12328833",
				:token => "EWFWKFJWE" #user email token
			)

```

### Disable subscription

```ruby

	subscriptions = PaystackSubscriptions.new(paystackObj)
	result = subscriptions.disable(
				:code => "12328833",
				:token => "EWFWKFJWE" #user email token
			)

```


## Split Payments

This Gem is also aware of the API calls that allow you to perform split payments on Paystack. The [Paystack documentation on split payments](https://developers.paystack.co/docs/split-payments-overview) can get you started. Below are some sample calls for [subaccounts](https://developers.paystack.co/docs/create-subaccount) and [banks](https://developers.paystack.co/docs/list-banks).

## Banks

### List Banks

```ruby

	page_number = 1
	banks = PaystackBanks.new(paystackObj)
	result = banks.list(page_number) 	#Optional `page_number` parameter,  50 items per page
	banks_list = result['data']

```

## Subaccounts

### List Subaccounts

```ruby

	page_number = 1
	subaccounts = PaystackSubaccounts.new(paystackObj)
	result = subaccounts.list(page_number) 	#Optional `page_number` parameter,  50 items per page
	subaccounts_list = result['data']

```

### Get a subaccount

```ruby

	subaccount_id = "123456778"
	subaccounts = PaystackSubaccounts.new(paystackObj)
	result = subaccounts.get(subaccount_id)
	subaccount =  result['data']

```

### Create new subaccount

```ruby

	subaccounts = PaystackSubaccounts.new(paystackObj)
	result = subaccounts.create(
		:business_name => "Madam Ikoro Holdings",
		:settlement_bank => "Providus Bank",
		:account_number => "1170766666"
		:percentage_charge => 3.2
	)

```

### Update subaccount details

```ruby

	subaccount_id = "123456778"
	subaccounts = PaystackSubaccounts.new(paystackObj)
	# Updating primary contact name and email of subaccount
	result = subaccounts.update(
		subaccount_id,
		:primary_contact_name => "Victoria Ikorodu",
		:primary_contact_email => "xxxxx-modified@gmail.com"
	)

```

## Settlements  
Fetch settlements made to your bank accounts and the bank accounts for your subaccounts

### List settlements

```ruby

	settlements = PaystackSettlements.new(paystackObj)
	results = settlements.list
	settlements_list = result['data']

```

## Transfers

The funds transfers feature enables you send money directly from your paystack balance to any Nigerian Bank account. The [Paystack documentation on transfers](https://developers.paystack.co/docs/funds_transfers) can get you started. 

## Balance

### Check Paystack Balance

```ruby
	
	balance = PaystackBalance.new(paystackObj)
	result = balance.get 	
	account_balance = result['data']

```

## Transfers

### Initialize a transfer

```ruby
	
	transfer = PaystackTransfers.new(paystackObj)
	results = transfers.initializeTransfer(
		:source => "balance", # Must be balance
		:reason => "Your reason",
		:amount => 30000, # Amount in kobo
		:recipient =>  recipient_code, # Unique recipient code
		)

```

### List transfers

```ruby

	page_number = 1
	transactions = PaystackTransfers.new(paystackObj)
	result = transfers.list(page_number) 	#Optional `page_number` parameter

```

### Get a transfer

```ruby

	transfer_code = "TRF_uniquecode"
	transactions = PaystackTransfers.new(paystackObj)
	result = transactions.get(transfer_code)

```

### Verify a transfer

```ruby

	reference = "unique_reference"
	transactions = PaystackTransfers.new(paystackObj)
	result = transactions.verify(reference)

```

### Finalize a transfer

```ruby
	
	transfer = PaystackTransfers.new(paystackObj)
	results = transfer.authorize(
		:transfer_code => "TRF_blablabla", # Must be balance
		:otp => "12350",
		)

```


## Transfer Recipients

### Create new recipient

```ruby

	recipient = PaystackRecipients.new(paystackObj)
	result = recipients.create(
		:type => "nuban", #Must be nuban
		:name => "Test Plan",
		:description => "Bla-bla-bla", 
		:account_number => 0123456789, #10 digit account number
		:bank_code => "044", #monthly, yearly, quarterly, weekly etc 
		:currency => "NGN",

	)
	
```

### List transfer recipients

```ruby
	page_number = 1
	recipients = PaystackRecipients.new(paystackObj)
	result = recipients.list(page_number) #Optional `page_number` parameter,  50 items per page
	recipients_list =  result['data']

```

## Transfer Control

### Resend OTP

```ruby
	transfer_code = "TRF_asdfghjkl"	#A unique Transfer code is generated when transfer is created
	transfer = PaystackTransfers.new(paystackObj)
	result = transfer.resendOtp(transfer_code) 	
	

```

### Disable OTP for transfers

```ruby

	transfer = PaystackTransfers.new(paystackObj)
	result = transfer.disableOtp  
	#OTP is sent to the registered phone number of the account

```

### Confirm disabling of OTP for transfers

```ruby

	otp = "12345"
	transfer = PaystackTransfers.new(paystackObj)
	# Updating primary contact name and email of subaccount
	result = transfer.confirmDisableOtp(
		:otp => otp, #Must be valid OTP sent to the registered phone number
	)

```

### Enable OTP for transfers

```ruby

	transfer = PaystackTransfers.new(paystackObj)
	result = transfer.enableOtp

```

## Static methods
`PaystackTransactions`, `PaystackCustomers`, `PaystackPlans`, `PaystackSubaccounts`, `PaystackBanks` , `PaystackSubscriptions` , `PaystackSettlements`, `PaystackBalance`, and `PaystackTransfers` methods can be called statically, You just need to pass the paystack object as the first parameter  e.g. `verify` method in `PaystackTransactions` can be called like this


```ruby

	transaction_reference = "blablablabla-YOUR-VALID-UNIQUE-REFERENCE-HERE"
	result = PaystackTransactions.verify(paystackObj, transaction_reference)
	puts result['message']

```




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IkoroVictor/paystack-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
