source "https://rubygems.org"

gem "rails", "3.1.6"

gem "airbrake"
gem "devise", "~> 1.5.3"
gem "haml", "~> 3.0.24"
gem "jquery-rails"
gem "kaminari" #, "~> 0.10.4"
gem "kronic", "~> 1.1.1"
gem "nokogiri", "~> 1.4.4"
gem "rake"
gem "RedCloth", "~> 4.2.3"
gem "resque", "~> 1.20.0"
gem "simple_form", "~> 1.2.2"
gem "validates_timeliness", "~> 3.0.0"
gem "yajl-ruby"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails" #, "~> 3.2.5"
  gem "coffee-rails" #, "~> 3.2.2"
  gem "uglifier"
end

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :production do
  gem "pg"
end

group :test, :development do
  gem "rspec-rails"
  gem "steak"
  gem "akephalos"
  gem "awesome_print", :require => "ap"
  gem "ffaker"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "launchy"
  gem "autotest"
  gem "autotest-growl"
  gem "database_cleaner"
end
