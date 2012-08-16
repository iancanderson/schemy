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

## Customization

By default, schemy will index:

- foo**_id** (foreign keys)
- foo**_id** and foo**_type** (polymorphic associations)
- **type** (for STI)

To create custom indexing rules, create a file in your rails app called config/schemy.yml.

###Example config/schemy.yml:

    indexed_columns:
      - identifier
      - - association_id
        - identifier

With the above configuration, schemy will create:

- an index for any column called identifier
- a compound index for any table that has **both** association_id and identifier

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
