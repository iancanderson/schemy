# Schemy

Schemy analyzes schema.rb to suggest new database indexes, providing a migration file that can be used directly.

## Installation

Add this line to your rails app's Gemfile in the development group:

    group :development do
      gem 'schemy'
    end

And then execute:

    $ bundle

## Usage

Within your rails app, run

    bundle exec rake schemy:indexes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
