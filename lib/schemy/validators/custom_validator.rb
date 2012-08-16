require_relative 'base_validator'

class CustomValidator < BaseValidator

  def validate_column column
    self.class.configured_column_combinations.each do |config_columns|

      config_columns = Array(config_columns)

      # Only validate this column if it's first in the combination config.
      # This way we don't create duplicate indices.
      if column == config_columns.first 
        # Only require an index if this table has all of the columns in the column combination.
        return unless config_columns[1..-1].all? { |col| @table.has_column? col }
        require_index config_columns
      end

    end
  end

  def self.config_file_path
    Rails.root.join 'config', 'schemy.yml'
  end

  def self.configured_column_combinations
    @configured_column_combinations ||= load_configured_column_combinations
  end

  def self.load_configured_column_combinations
    if File.exists? config_file_path
      config = YAML.load_file config_file_path
      config['indexed_columns']
    else
      []
    end
  end

end
