require_relative 'fake_index'

class FakeTable
  attr_reader :name
  attr_reader :columns

  def initialize(table_name)
    @name = table_name
    @columns = []
    @indices = []
  end
  def add_index(column_name, options = {})
    @indices << FakeIndex.new(self, Array(column_name), options)
  end
  def method_missing(m, *args, &block)
    data_types = [:string, :text, :integer, :float, :decimal, :datetime,
        :timestamp, :time, :date, :binary, :boolean]
    if data_types.include? m
      # method names are column data types
      @columns << FakeColumn.new(args[0], m)
    else
      super
    end
  end
  def to_s
    output = "=" * 30
    output += "\n#{table_name}:\n"
    output += @columns.inject(''){ |output, column| output += "#{column}\n" }
  end
  def has_index? columns
    @indices.detect{ |index| index.match_columns? columns }
  end
  def has_column? column_name
    @columns.detect{ |col| col.name.to_sym == column_name.to_sym }
  end
end
