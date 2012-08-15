namespace :schemy do

  desc 'Analyze schema.rb for indexing opportunities.'
  task indexes: :environment do
    analyzer = Schemy::Analyzer.new(Rails.root.join('db', 'schema.rb'))
    analyzer.create_migration

    puts "Schemy here."
    puts "It looks like you need #{analyzer.new_indices_count} new indices."
    puts "I created a migration for you to add new indices: #{analyzer.migration_file_path}"
  end

end

