source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'mail_form'

# Use sqlite3 as the database for Active Record
group :development do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
  #MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface.
  #check out http://127.0.0.1:1080 to see the mail.
  gem 'mailcatcher'
  gem 'debugger'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
group :development, :test do
  gem 'rspec-rails'
end
group :coverage do
    gem 'simplecov', :require => false
  end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'xing_api'
gem 'bootstrap-sass-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development
