# SequelAsteriskHunter

[![Maintainability](https://api.codeclimate.com/v1/badges/45c9c0861e32902a4b0a/maintainability)](https://codeclimate.com/github/danilobarion1986/sequel-asterisk-hunter/maintainability)

This extension hooks into `Sequel::Dataset#fetch_rows` method, doing some predefined action when an `SELECT *` statement is found.

## Installation

Add this line to your application's Gemfile:

    gem 'sequel-asterisk-hunter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-asterisk-hunter

## Usage

The extension needs to be initialized by the Sequel extension interface. 
The simplest way to configure it globally is by adding this line to the initializer:

```ruby
Sequel.extension :asterisk_hunter
```
or
```ruby
Sequel::Database.extension :asterisk_hunter
```

However, if you are using any framework (like Rails) where your Sequel::Database instance already exists, you should use `DB.extension :asterisk_hunter`, where `DB` is a reference to your Sequel::Database, like this:

```ruby
Sequel::Model.db.extension :asterisk_hunter
```

You could define an action to be executed when any `SELECT *` statement is found. It must be any callable object.

### Examples

With the default action:
```ruby
DB[:my_table].all
  #=> "Find 'SELECT *' in query!"
  #=> [<All your objects and its attributes/columns>]
```

With some custom actions defined:
- Raising an error:
```ruby
action = -> { raise StandardError, "Find 'SELECT *' in query!" }
Sequel::Extensions::AsteriskHunter.define_action(action)

DB[:my_table].all
  #=> StandardError("Find 'SELECT *' in query!")
  # (Your query is not executed...)
```

- Logging:
```ruby
action = -> { Rails.logger.warn("Find 'SELECT *' in query!") }
Sequel::Extensions::AsteriskHunter.define_action(action)

DB[:my_table].all
  #=> "Find 'SELECT *' in query!"
  #=> [<All your objects and its attributes/columns>]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
