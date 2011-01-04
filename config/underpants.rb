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
end

on_first_deploy do
  run "bundle --deployment"
end
