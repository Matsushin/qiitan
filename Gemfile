source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'hamlit'
gem 'bootstrap-sass'
gem 'devise'
gem 'devise-i18n'
gem 'devise-bootstrap-views'
gem 'simple_form'
gem 'kaminari'
gem 'ransack'
gem 'carrierwave'
gem 'font-awesome-sass'
gem 'gemoji'
gem 'enumerize'
gem 'fog'
gem 'mini_magick'
gem 'retryable'
gem 'roboto'
gem 'redcarpet'
gem 'rouge'
gem 'rack-dev-mark'
gem 'foreman'
gem 'sentry-raven'
gem 'newrelic_rpm'

source 'https://rails-assets.org' do
  gem 'rails-assets-toastr'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'erb2haml'
  gem 'letter_opener_web'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'email_spec'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
end