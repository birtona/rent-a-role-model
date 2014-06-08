# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

RentARoleModel::Application.load_tasks

#Run RSpec with code coverage"
task :coverage do
  ENV['COVERAGE'] = true
  Rake::Task["spec"].execute
end