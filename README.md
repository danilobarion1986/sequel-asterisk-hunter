# SequelAsteriskHunter

This extension adds the `Sequel::Dataset#hunt` method, which...

## Installation

Add this line to your application's Gemfile:

    gem 'sequel-asterisk-hunter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-asterisk-hunter

The plugin needs to be initialized by the Sequel extension interface. The simplest way to configure plugin globally is adding this line to the initializer:

```ruby
Sequel.extension :asterisk_hunter
```
or
```ruby
Sequel::Database.extension :asterisk_hunter
```

But anyway I recommend reading more about [Sequel extensions system](https://github.com/jeremyevans/sequel/blob/master/doc/extensions.rdoc#sequel-extensions).

## Usage

```ruby
dataset.hunt
```

## Usage examples

### Hunting 'SELECT * ...'
```ruby
DB[:my_table].hunt
  #=> 'Find It!'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
