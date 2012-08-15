require_relative 'base_validator'

class TypeValidator < BaseValidator

  def validate_column column
    if column == 'type'
      require_index column
    end
  end
end
