# Splendid Bacon

Project Management* for hackers

* <http://blog.kiskolabs.com/post/24195529239/open-source-bacon>
* <http://blog.kiskolabs.com/post/20108267834/the-regrettable-end-of-splendid-bacon>

## Caveats

There are a few issues that should be fixed before taking this into production use:

* Fix the [mass assignment vulnerabilities](http://guides.rubyonrails.org/security.html#mass-assignment) (this is the most important thing)
  * Rails 3.0: `ActiveRecord::Base.send(:attr_accessible, nil)`
  * Rails 3.1: `config.active_record.whitelist_attributes = true`
  * Rails 3.2: `config.active_record.mass_assignment_sanitizer = :strict`
* Upgrade to a more recent Rails version (in other words, Rails 3.2.x)
* Remove the Mailchimp integration
* Remove the Zendesk integration

There is a `rails_upgrade` branch where some of this work has been started and pull requests are definitely welcome.

*Note: Any API keys included in the source code have been revoked and cannot be used.*

## Installation (for development)

1. Clone the repository

    `git clone git@github.com:kiskolabs/splendidbacon.git`

2. Check that you have the right ruby version (> 1.9.2)

3. Install the required gems

    `bundle install`

    in development you might want to also pass `--without production`

4. Create database.yml in the config folder. You can `cp config/database.example.yml config/database.yml` to get a starting point.

5. Setup the database (create DB, load schema, load seed data)

    `rake db:setup`

6. Start the app

    `rails server`

The admin console is located at <http://localhost:3000/magic>

## License and Copyright

Copyright © 2010-2012 Kisko Labs & contributors.

Licensed under the MIT license. See the LICENSE file for the full license text.