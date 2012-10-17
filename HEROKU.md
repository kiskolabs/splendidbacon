# How to Deploy to Heroku

## Prerequisites

* A Ruby installation (>= 1.9.2)
* Heroku CLI tools (<https://toolbelt.heroku.com/>)

## Create the Heroku app

1. Clone the repository (if you haven't already)
2. `bundle install --without production`
3. `heroku create`
4. `heroku addons:add sendgrid:starter`
5. `heroku addons:add pgbackups:auto-month` *(optional)*
6.  Configure the `SECRET_TOKEN` and `HOST`:

    heroku config:add SECRET_TOKEN=\`rake secret` HOST=name.herokuapp.com

7. `git push heroku master`
8. `heroku run rake db:migrate`
9. Go to `http://<name>.herokuapp.com` to create an account
10. Create an admin:
  * `heroku run console`
      * In the console: `Admin.create(email: "your@email.com", password: "secret")`
      * To leave the Rails console: `exit`
  * Log in as an admin on `http://<name>.herokuapp.com/magic`
