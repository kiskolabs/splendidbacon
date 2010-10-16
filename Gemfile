source "http://rubygems.org"

gem "rails", "3.0.1"
gem "unicorn"
gem "haml"
gem "devise"
gem "simple_form"
gem "RedCloth"
gem "validates_timeliness", "3.0.0.beta.5"

group :development do
  gem "awesome_print", :require => "ap"
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :production do
  gem "mysql2"
end

group :test, :development do
  gem "rspec-rails"
end

group :test do
  gem "cucumber-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "launchy"
  gem "autotest"
  gem "autotest-growl"
end
