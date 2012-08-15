class Schemy::Analyzer

  def initialize(schema_path)
    @schema_path = schema_path
  end

  def create_migration
    File.open(migration_file_path, 'w') do |f|
      f.write(migration_string)
    end
  end

  def migration_file_path
    Rails.root.join 'db', 'migrate', migration_file_base_name + '.rb'
  end

  def new_indices_count
    new_indices.count
  end

  private

  def analyze
    # load in our implementation of ActiveRecord::Schema
    require_relative 'schema_checker'
    # evaluate the schema with our Schema class
    @results = eval(schema)
  end

  def migration_class_name
    "AddIndices#{migration_timestamp}"
  end

  def migration_file_base_name
    @migration_file_base_name ||= "#{migration_timestamp}_add_indices_#{migration_timestamp}"
  end

  def migration_string
    if new_indices.any?
      
<<MIGRATION
class #{migration_class_name} < ActiveRecord::Migration

  def self.up
#{new_indices.map{|i| "    #{i.to_s}" }.join "\n"}
  end

  def self.down
#{new_indices.map{|i| "    #{i.to_s :down}" }.join "\n"}
  end

end
MIGRATION

    end
  end

  def migration_timestamp
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def new_indices
    results.new_indices
  end

  def results
    return @results if @results
    analyze
    @results
  end

  def schema
    file = File.open(@schema_path, "r")
    contents = file.read
    file.close
    contents
  end

end
