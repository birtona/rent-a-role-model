# rent-a-role-model [![Build Status](https://travis-ci.org/birtona/rent-a-role-model.png?branch=master)](https://travis-ci.org/birtona/rent-a-role-model)

* Find the demo live version here: https://rent-a-role-model.herokuapp.com
* About: http://rent-a-role-model.herokuapp.com/home/about

* Rent a Role Model uses Ruby 1.9.3p392 and Rails 4.0.0

## Setup in your Terminal

* git clone git@github.com:birtona/rent-a-role-model.git
* cd rent-a-role-model
* bundle install
* bundle exec rake db:migrate
* bundle exec rails s

-> open localhost:3000 in your browser and register as a role model with your xing login

## Run the tests

* bundle exec rake db:create db:migrate RAILS_ENV=test
* bundle exec rake

