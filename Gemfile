source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem 'rake', '0.8.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', '0.2.7'
gem 'resque'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generatorss
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rails3-generators'
  gem "jquery-rails"
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'resque_unit'
  gem "capybara"
  gem "launchy"
  gem 'factory_girl_rails'
  gem 'ZenTest'
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
  gem 'shoulda-context'
end
