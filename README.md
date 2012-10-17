# Splendid Bacon

Project Management* for hackers

* <http://blog.kiskolabs.com/post/24195529239/open-source-bacon>
* <http://blog.kiskolabs.com/post/20108267834/the-regrettable-end-of-splendid-bacon>

## Caveats

There are a few issues that should be fixed before taking this into production use:

* Fix the [mass assignment vulnerabilities](http://guides.rubyonrails.org/security.html#mass-assignment) (this is the most important thing)
  * `config.active_record.mass_assignment_sanitizer = :strict`
  * `config.active_record.whitelist_attributes = true`

*Note: Any API keys included in the source code have been revoked and cannot be used.*

## Installation (for development)

1. Clone the repository

    `git clone git@github.com:kiskolabs/splendidbacon.git`

2. Check that you have the right ruby version (> 1.9.2)

3. Install the required gems

    `bundle install`

    in development you might want to also pass `--without production`

4. Create database.yml in the config folder. You can `cp config/database.example.yml config/database.yml` to get a starting point.

5. Create the `.env` file. You can `cp sample.env .env` to get a starting point.

6. Setup the database (create DB, load schema, load seed data)

    `rake db:setup`

7. Start the app

    `foreman start`

The admin console is located at <http://localhost:5000/magic>

**NB. The session secret must be set as an environment variable called `SECRET_TOKEN`.**

You can generate a new secret with `rake secret`.

On Heroku, you can set the session secret with this one-liner:

    heroku config:add SECRET_TOKEN=\`rake secret`

[Foreman](http://ddollar.github.com/foreman/) is included to make managing environment variables easier in development. Include any environment variables you need in a `.env` file (see `sample.env` as a reference).

## Tests [![Build Status](https://secure.travis-ci.org/kiskolabs/splendidbacon.png?branch=master)](http://travis-ci.org/kiskolabs/splendidbacon)

Run the test suite with:

    bundle exec rake spec

Or:

    bundle exec rspec spec

## License and Copyright

Copyright © 2010-2012 Kisko Labs & contributors.

Licensed under the MIT license. See the LICENSE file for the full license text.