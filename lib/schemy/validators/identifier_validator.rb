require_relative 'base_validator'

class IdentifierValidator < BaseValidator

  def validate_column column
    if column == 'identifier'
      require_index column
    end
  end
end
