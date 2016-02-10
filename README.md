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

## Usage

### 1. Instantiate Paystack Object

```ruby

    paystack = Paystack.new(public_key, secret_key)

```

A more secure way is to set your public and private keys as environmental variables `PAYSTACK_PUBLIC_KEY` and `PAYSTACK_PRIVATE_KEY` respectively. Then you instantiate without parameters

```ruby

	paystack =  Paystack.new

```
It throws a `PaystackBadKeyError` when either of the keys are invalid or cannot be found as environment variables.

Methods available in the Paystack class include


### 2. Instantiate a Card object

```ruby
	card = new PaystackCard(
		:number => "304402040400400022", 
		:cvc => "888", 
		:expiryMonth => "07",
		:expiryYear => "19"
		)

	isvalid = card.isValidCard
```
The `isValidCard` method determines the validity of the card i.e. Expiry status, Luhn validity,





## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IkoroVictor/paystack-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

