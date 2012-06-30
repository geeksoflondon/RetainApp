source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'

# Asset template engines
gem 'json'
gem 'sass-rails', "~> 3.1.0"
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

# Gems for image uploads
gem 'carrierwave'
gem 'fog'
gem  'rmagick'

#auth
gem 'omniauth', '0.3.0.rc3'

#pdf stuff
gem 'prawn_rails'
gem 'barby'
gem 'rqrcode'

group :development do 
  gem 'heroku'
  gem 'mysql'
end

group :production do
  gem 'pg'
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'object-factory'
  gem 'timecop'
  gem 'database_cleaner'
end