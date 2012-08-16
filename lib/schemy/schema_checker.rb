Dir[File.dirname(__FILE__) + '/validators/*.rb'].each do |file|
  require_relative File.join "validators", File.basename(file)[0...-3]
end

require_relative 'fake_table'
require_relative 'fake_column'

module ActiveRecord
  class Schema

    DEFAULT_VALIDATORS = [CustomValidator, ForeignKeyValidator, TypeValidator]

    def self.define(options= {}, &block)
      schema = new
      schema.instance_eval &block
      schema.schemy_results
    end

    def initialize
      @tables = []
    end

    def create_table(table_name, options = {}, &block)
      @tables << FakeTable.new(table_name)
      yield @tables.last
    end

    def add_index(table_name, column_name, options = {})
      get_table_by_name(table_name).add_index(column_name, options)
    end

    def to_s
      @tables.inject(''){ |output, table| output += "#{table}\n" }
    end

    def schemy_results
      new_indices = []
      @tables.each do |table|
        DEFAULT_VALIDATORS.each do |validator_klass|
          new_indices += validator_klass.new(table).validate
        end
      end
      Struct.new(:new_indices).new(new_indices)
    end

    private

    def get_table_by_name(table_name)
      @tables.detect{ |table| table.name == table_name }
    end

  end

end

