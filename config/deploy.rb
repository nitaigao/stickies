set :application, "StoryHub"
set :domain,      "blackartstudios.net"
set :repository,  "git@github.com:nkostelnik/StoryHub.git"
set :use_sudo,    false
#set :deploy_to,   "/path-to-your-web-app-directory/#{application}"
set :scm,         "git"

set :user, "root"
set :password, "aede90d7e5"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end