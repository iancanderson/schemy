class BaseValidator

  attr_reader :table

  def initialize(table)
    @table = table
  end

  # returns array of unindexed columns which should be indexed
  def validate
    @missing_indices = []
    @table.columns.each do |column|
      validate_column column.name.to_s
    end
    @missing_indices
  end

protected
  def validate_column(column)
  end

  def require_index(columns)
    columns = Array columns
    # will add to @missing_indices if no index is present for the columns
    unless @table.has_index? columns
      @missing_indices << index_from_columns(columns)
    end
  end

  def index_from_columns columns
    FakeIndex.new @table, columns
  end
end
