source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

gem 'jsonapi-hanami', github: 'jsonapi-rb/jsonapi-hanami'

gem 'pg'

gem 'jwt'
gem 'bcrypt', require: false
gem 'warden'

gem 'transproc'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'byebug'
  gem 'dotenv', '~> 2.0'
end

group :test do
  gem 'minitest'
  gem 'factory_bot'
  gem 'faker'
end

group :production do
  gem 'puma'
end
