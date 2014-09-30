source 'https://rubygems.org'

gem 'rails', '4.1.6'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'pg'
gem 'bcrypt', '~> 3.1.7'
gem 'unicorn'
gem "codeclimate-test-reporter", group: :test, require: nil
gem 'postgres-copy'

group :production do
  gem "skylight"
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'faker'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'capybara'
  gem 'shoulda-matchers', require: false
  gem 'launchy'
  gem 'pry'
end

group :test do
  gem 'simplecov', require: false
  gem 'nyan-cat-formatter'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
