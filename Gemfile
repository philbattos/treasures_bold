source 'https://rubygems.org'

#==============================#
# Rails default gems           #
#==============================#
gem 'rails', '~> 5.0.0'                       # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'puma', '~> 3.0'                          # Use Puma as the app server
gem 'sass-rails', '~> 5.0'                    # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'                    # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.2'                  # Use CoffeeScript for .coffee assets and views
gem 'jquery-rails'                            # Use jquery as the JavaScript library
gem 'turbolinks', '~> 5'                      # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jbuilder', '~> 2.5'                      # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'therubyracer', platforms: :ruby        # See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'redis', '~> 3.0'                       # Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7'                    # Use ActiveModel has_secure_password
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment
# gem 'sqlite3'                               # Use sqlite3 as the database for Active Record

#==============================#
# Added gems for this app      #
#==============================#
gem 'haml'                                    # use haml instead of html
gem 'pg'                                      # use postgres database instead of sqlite
gem 'bootstrap', '~> 4.0.0'                   # use Bootstrap for styling
gem 'gon'                                     # use Gon to pass variables from Rails to Haml to Javascript (Google Maps)

#==============================#
# Environment-dependent gems   #
#==============================#
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'haml-rails'
  gem 'dotenv-rails'                          # use Dotenv to store local ENV variables
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
