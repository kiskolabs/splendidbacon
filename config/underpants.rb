repository  "git@github.com:railsrumble/rr10-team-83.git"
app_name    "splendidbacon"
rvm_ruby    "1.9.2"

environment :production do
  server    "splendidbacon.r10.railsrumble.com"
  app_url   "splendidbacon.r10.railsrumble.com"
end

on_deploy do
  run "bundle install --deployment"
  run "rake db:migrate"
end

on_first_deploy do
  run "rake db:seed"
end