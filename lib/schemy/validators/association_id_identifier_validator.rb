require_relative 'base_validator'

class AssociationIdIdentifierValidator < BaseValidator

  def validate_column column
    if column == 'association_id' && @table.has_column?('identifier')
      require_index ['association_id', 'identifier']
    end
  end
end
