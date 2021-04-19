source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby('2.7.1')

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem('rails', '~> 6.0.3', '>= 6.0.3.2')
# Use postgresql as the database for Active Record
gem('pg', '>= 0.18', '< 2.0')
# Use Puma as the app server
gem('puma', '~> 4.1')
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem('webpacker', '~> 4.0')
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem('turbolinks', '~> 5')
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem('jbuilder', '~> 2.7')
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem('bootsnap', '>= 1.4.2', require: false)
gem('geocoder', '~> 1.6', '>= 1.6.4')
gem('view_component', require: 'view_component/engine')
gem('scenic')


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails_best_practices'
  gem 'better_errors'
  gem 'brakeman'
  gem 'rubocop', require: false
  gem 'rubocop-shopify', require: false

  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem('tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby])
gem('devise')
gem('rolify')
gem("pundit")
gem('pagy', '~> 3.5')
gem('ransack')
gem("shrine", "~> 3.2")
gem("aws-sdk-s3", "~> 1.14")
gem("s3_direct_upload", github: "waynehoover/s3_direct_upload")
gem('fastimage')
gem('acts-as-taggable-on', '~> 6.0')
gem('sidekiq')
gem('sidekiq-status')
gem('redis-namespace')
gem('sitemap_generator')
gem('image_processing', '~> 1.12')
gem('ruby-vips', '~> 2.0')
gem("roo")
gem('roo-xls')
gem('omniauth-facebook')
gem('omniauth-google-oauth2')
gem('mailgun-ruby', '~>1.2.3')
gem('omniauth-twitter')
gem('twitter')
