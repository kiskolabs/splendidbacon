# Splendid Bacon


Project Management* for hackers

<http://blog.kiskolabs.com/post/20108267834/the-regrettable-end-of-splendid-bacon>

## Installation

1. Clone the repository

    `git clone git@github.com:kiskolabs/splendidbacon.git`

2. Check that you have the right ruby version (> 1.9.2)

3. You need to have QT installed to run the test suite. Install it with:

    `brew update && brew install qt`

    If it doesn't work, you can find instructions here: <https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit>

4. Install the required gems

    `bundle install`

    in development you might want to also pass `--without production`

5. Create database.yml in the config folder. You can `cp config/database.example.yml config/database.yml` to get a starting point.

6. Setup the database (create DB, load schema, load seed data)

    `rake db:setup`

7. Start the app

    `rails server`

## License and Copyright

Copyright © 2010-2012 Kisko Labs.

Licensed under the MIT license. See the LICENSE file for the full license text.