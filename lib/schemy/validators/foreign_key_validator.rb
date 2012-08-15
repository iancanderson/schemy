require_relative 'base_validator'

class ForeignKeyValidator < BaseValidator

  def validate_column column
    if column =~ /_id$/
      type_column = column[0...-2] + 'type'
      if table.has_column? type_column
        require_index [type_column, column]
      else
        require_index column
      end
    end
  end
end
