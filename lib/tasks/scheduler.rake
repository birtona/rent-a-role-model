desc "This task is called by the Heroku scheduler add-on. It synchronizes user data."
task :synchronize_users => :environment do
  puts "Synchronize users..."
  User.all.each do |user|
    Task.sync_with_xing(user)
  end
  puts "done."
end
