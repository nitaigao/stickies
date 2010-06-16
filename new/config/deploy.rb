set :application, "energy"
set :repository,  "git@github.com:trafficbroker/energy.git"
set :user, "deploy"

set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"

set :scm_verbose, true
set :scm, :git

role :web, "173.203.215.202"
role :app, "173.203.215.202"
role :db,  "173.203.215.202", :primary => true

set :context_root, "/" # You can obviously change this if you want to
set :glassfish_location, "/usr/local/glassfishv3"
set :jruby_location, "/usr/local/jruby"

namespace :deploy do
  desc "Cold start Glassfish v3"
  task :cold do
    run "#{glassfish_location}/bin/asadmin start-domain domain1"
    start
  end

  desc "Stop a server running Glassfish v3"
  task :stop do
    run "#{glassfish_location}/bin/asadmin undeploy #{current_dir} || true"
    run "#{glassfish_location}/bin/asadmin stop-domain domain1"
  end

  desc "update and deploy to Glassfish v3"
  task :start do
    update
    run "#{glassfish_location}/bin/asadmin deploy --property jruby.home=#{jruby_location} --contextroot #{context_root} #{deploy_to}/#{current_dir}"
  end

  desc "restart the application"
  task :restart do
    run "#{glassfish_location}/bin/asadmin deploy --property jruby.home=#{jruby_location} --force=true --contextroot #{context_root} #{deploy_to}/#{current_dir}"
  end

  desc "Undeploy the application"
    task :undeploy do
    run "#{glassfish_location}/bin/asadmin undeploy #{current_dir}"
  end
end