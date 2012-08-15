require 'digest/md5'

class FakeIndex
  MAX_INDEX_NAME_LENGTH = 63

  def initialize(table, column_names, options = {})
    @column_names = column_names
    @table = table
  end

  def match_columns? columns
    columns.map(&:to_s).sort == @column_names.map(&:to_s).sort
  end

  def to_s(direction = :up)
    if direction == :up
      %[add_index '#{table_name}', [#{column_names_quoted}], :name => "#{index_name}"]
    elsif direction == :down
      %[remove_index '#{table_name}', :name => "#{index_name}"]
    end
  end

  def table_name
    @table.name
  end

  def column_names_quoted
    @column_names.map do |c|
      "'#{c}'"
    end.join ','
  end
  def column_names_anded
    @column_names.join '_and_'
  end
  def index_name
    # Postgres only supports index names up to 63 chars
    name = "index_#{table_name}_on_#{column_names_anded}"
    if name.length > MAX_INDEX_NAME_LENGTH
      md5 = Digest::MD5.hexdigest(name)
      name = "index_#{table_name}_#{md5[0...10]}"
      name = "index_#{md5[0...20]}" if name.length > MAX_INDEX_NAME_LENGTH
    end
    name
  end
end
