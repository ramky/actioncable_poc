source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sprockets-rails"
gem 'redis'
gem 'faker'
# gem "importmap-rails"
# gem "turbo-rails"
# gem "stimulus-rails"
# gem "jbuilder"
gem 'bcrypt'
gem 'jwt'
gem 'simple_command'
gem 'google-protobuf'

gem 'karafka'
gem 'karafka-web'

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  #gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'pry-byebug'
end

group :development do
  gem "web-console"
end

