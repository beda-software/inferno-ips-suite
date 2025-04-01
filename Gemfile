# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development, :test do
  gem 'debug'
  gem 'rubocop', '~> 1.9'
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'database_cleaner-sequel', '~> 1.8'
  gem 'factory_bot', '~> 6.1'
  gem 'rack-test'
  gem 'rspec', '~> 3.10'
  gem 'simplecov', '0.21.2', require: false
  gem 'webmock', '~> 3.11'
end

gem 'inferno_ps_suite_generator', git: 'https://github.com/beda-software/inferno_ps_suite_generator',
                                  ref: '38cd57e7c42131cec996fd424000308f788abc7e'
