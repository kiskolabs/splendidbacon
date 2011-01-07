source :rubygems

gem "rails", "3.0.3"
gem "haml", "~> 3.0.24"
gem "devise", "~> 1.1.3"
gem "simple_form", "~> 1.2.2"
gem "RedCloth", "~> 4.2.3"
gem "validates_timeliness", "~> 3.0.0"
gem "kronic", "~> 1.1.1"
gem "hoptoad_notifier"
gem "will_paginate", "~> 3.0.beta"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :production do
  gem "pg"
  gem "rack-ssl", "~> 1.1.0", :require => "rack/ssl"
  gem "newrelic_rpm", "~> 2.13.4"
end

group :test, :development do
  gem "rspec-rails", "~> 2.2.0"
  gem "steak", "~> 1.0.1"
end

group :test do
  gem "cucumber-rails", :git => "git://github.com/aslakhellesoy/cucumber-rails.git", :ref => "ad3a1f4ffdab02fe6871"
  gem "factory_girl_rails", "~> 1.0.0"
  gem "capybara", "~> 0.4.0"
  gem "launchy"
  gem "autotest"
  gem "autotest-growl"
end
