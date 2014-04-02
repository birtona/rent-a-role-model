require 'resque_scheduler/tasks'

desc "This task is called by the Heroku scheduler add-on. It synchronizes user data."
task :synchronize_users => :environment do
  puts "Synchronize users..."
  users = User.find_all()
  users do |user|
  	User.update_existing_user(user)
  puts "done."
end
