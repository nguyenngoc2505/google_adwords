source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'

# Common
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'puma', '~> 3.0'
gem 'slim'
gem 'foundation-rails'

# Authenticate
gem 'devise'

#ORM
gem 'pg', '~> 0.18'

group :development, :test do
  gem 'pry-byebug'
  gem 'better_errors'
end

group :development do
  gem 'rubocop', require: false
  gem 'foreman'
  gem 'rubocop-checkstyle_formatter'
  gem 'brakeman'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'rails_12factor'
end
