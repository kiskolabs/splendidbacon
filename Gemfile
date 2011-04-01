source :rubygems

gem "rails", "3.0.5"
gem "haml", "~> 3.0.24"
gem "devise", "~> 1.1.3"
gem "simple_form", "~> 1.2.2"
gem "RedCloth", "~> 4.2.3"
gem "validates_timeliness", "~> 3.0.0"
gem "kronic", "~> 1.1.1"
gem "hoptoad_notifier"
gem "will_paginate", "~> 3.0.beta"
gem "nokogiri", "~> 1.4.4"
gem "hominid", "~> 3.0.2"
gem "yajl-ruby", "~> 0.7.9"
gem "resque", "~> 1.10.0", :require => "resque"
gem "zendesk_remote_auth"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
end

group :production do
  gem "pg"
  gem "rack-ssl", "~> 1.1.0", :require => "rack/ssl"
  gem "newrelic_rpm", "~> 2.13.4"
end

group :test, :development do
  gem "rspec-rails"
  gem "steak"
  gem "akephalos"
  gem "awesome_print", :require => "ap"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "launchy"
  gem "autotest"
  gem "autotest-growl"
  gem "database_cleaner"
end
