repository  "git@github.com:kiskolabs/splendidbacon.git"
app_name    "splendidbacon"
# app_user    "app"
# deploy_base "/srv"

environment :production do
  server    "pancetta.splendidbacon.com"
  app_url   "pancetta.splendidbacon.com"
end

on_deploy do
  run "bundle --deployment"
  run "rake db:migrate"
  run "rm -f public/stylesheets/all.css"
  run "rm -f public/stylesheets/magic_all.css"
  run "rm -f public/javascripts/all.js"
  run 'bundle exec newrelic deployments -r `git log -1 --format="%H"`'
  run 'bundle exec rake airbrake:deploy TO=production REVISION=`git log -1 --format="%H"`'
end

on_first_deploy do
  run "bundle --deployment"
end
