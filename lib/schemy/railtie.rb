module Schemy
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/schemy.rake"
    end
  end
end
