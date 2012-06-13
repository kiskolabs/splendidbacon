source :rubygems

gem "rails", "3.1.6"
gem "haml", "~> 3.0.24"
gem "devise", "~> 1.5.3"
gem "simple_form", "~> 1.2.2"
gem "RedCloth", "~> 4.2.3"
gem "validates_timeliness", "~> 3.0.0"
gem "kronic", "~> 1.1.1"
gem "airbrake"
gem "kaminari" #, "~> 0.10.4"
gem "nokogiri", "~> 1.4.4"
gem "hominid", "~> 3.0.2"
gem "yajl-ruby"
gem "resque", "~> 1.10.0"
gem "zendesk_remote_auth"
gem "rake"

gem "jquery-rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails" #, "~> 3.2.5"
  gem "compass-rails"
  gem "coffee-rails" #, "~> 3.2.2"
  gem "uglifier"
end

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :production do
  gem "pg"
#  gem "rack-ssl", "~> 1.1.0", :require => "rack/ssl"
#  gem "newrelic_rpm", "~> 3.0.1"
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
