source :rubygems

gem "rails", "3.0.3"
gem "haml", "~> 3.0.24"
gem "devise", "~> 1.1.3"
gem "simple_form", "~> 1.2.2"
gem "RedCloth", "~> 4.2.3"
gem "validates_timeliness", "~> 3.0.0"
gem "kronic", "~> 1.1.1"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :production do
  gem "mysql2"
  gem "unicorn"
end

group :test, :development do
  gem "rspec-rails", "~> 2.0.1"
end

group :test do
  gem "cucumber-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "launchy"
  gem "autotest"
  gem "autotest-growl"
end
