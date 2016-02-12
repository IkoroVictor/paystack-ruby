# Paystack


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



### Instantiate a Card object

```ruby
	card = new PaystackCard(
		:number => "304402040400400022", 
		:cvc => "888", 
		:expiryMonth => "07",
		:expiryYear => "19"
		)

	isvalid = card.isValidCard
```
The `isValidCard` method determines validity of the card i.e. Expiry status, Luhn checksum validity etc.
All card values/fields should be String literals.



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

	transaction_id = ""123456778""
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

	plan_id = ""123456778""
	plans = PaystackPlans.new(paystackObj)
	result = plans.update(
			plan_id,
			:name => "Test Plan Updated",
			:amount => 500000, #in KOBO
			:interval => "weekly" 
			)

```


## Static methods
`PaystackTransactions`, `PaystackCustomers` and `PaystackPlans` methods can be called statically, You just need to pass the paystack object as the first parameter  e.g. `verify` method in `PaystackTransactions` can be called like this


```ruby

	transaction_reference = "blablablabla-YOUR-VALID-UNIQUE-REFERENCE-HERE"
	result = PaystackTransactions.verify(paystackObj, transaction_reference)
	puts result['message']

```




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IkoroVictor/paystack-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

