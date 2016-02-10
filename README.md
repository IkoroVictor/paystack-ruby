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

Methods available in the Paystack class include


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

### Generate card token

```ruby
	
	results = paystackObj.getToken(card)
	cardToken = results[:token]

```
Throws a PaystackCardError if card is invalid i.e `isValidCard` returns false or card is nil


### Charge Customer with token 

```ruby

	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.chargeToken(
		cardToken, 
		100000,
		:email => "xxxxxx@gmail.com",
		:reference => "blablablablaYOUR-UNIQUE-REFERENCE-HERE"
		)
```
or you can call method statically (applicable to other methods available in PaystackTransactions class)

```ruby

	result = PaystackTransactions.chargeToken(
		paystackObj,
		cardToken, 
		100000,
		:email => "xxxxxx@gmail.com",
		:reference => "blablablabla-YOUR-UNIQUE-REFERENCE-HERE"
		)
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

### Initialize transaction and get Authorization URL 

```ruby

	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.initializeTransaction(
		:reference => "blablablabla-YOUR-UNIQUE-REFERENCE-HERE",
		:amount => 300000,
		:email => "xxxxxx@gmail.com",
		)
	auth_url = results['data']['authorization_url']
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

	transaction_id = 123456778
	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.get(transaction_id) 

```

### Verify a transaction

```ruby

	transaction_reference = "blablablabla-YOUR-UNIQUE-REFERENCE-HERE"
	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.verify(transaction_reference) 

```

### Get transaction totals

```ruby

	transactions = PaystackTransactions.new(paystackObj)
	result = transactions.totals() 

```



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IkoroVictor/paystack-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

