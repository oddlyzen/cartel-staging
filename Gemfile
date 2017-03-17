source 'https://rubygems.org'

ruby '2.3.3'

gem 'rails', '~> 4.2.7.1'

gem 'pg'
gem 'unicorn-rails'

# front-end
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'slim-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'country_select', '~> 2.0'
gem 'simple_form'
gem 'language_list', '~> 1.1'
gem 'cocoon', '~> 1.2.0'
gem 'classy_enum', '~> 4.0'
gem 'selectize-rails'
gem 'gon'
gem 'jquery-ui-rails', '~> 5.0'
gem 'responders', '~> 2.0'
gem 'city-state', git: 'https://github.com/ocularch/city-state'
gem 'kaminari'

# authentication & authorization
gem 'sorcery'

gem 'paper_trail', '~> 4.0.0'

gem 'aasm'

# file uploading
gem 'filepicker-rails'

gem 'appsignal'

group :development, :test do
  gem 'dotenv-rails', '~> 2.1.0'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'byebug'
  gem 'slim_lint'
  gem 'email_spec'
  gem 'rspec-html-matchers'
  gem 'pry-rails'
  gem 'rollbar'
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'newrelic_rpm'


end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'spring'
  gem 'bullet'

  gem 'rb-readline'
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
end

group :test do
  # gem 'capybara'
  # gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: nil
  gem 'rubocop'
  gem 'webmock'
end

gem 'rails_admin'
gem "rails-erd"
