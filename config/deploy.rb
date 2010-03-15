set :application, "Websites"
set :repository,  "git@github.com:nkostelnik/Websites.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "nkostelnik"
set :password, "n8frAVan"

role :web, "nkostelnik@blackartstudios.net"                          # Your HTTP server, Apache/etc
role :app, "blackartstudios.net"                          # This may be the same as your `Web` server
role :db,  "blackartstudios.net", :primary => true # This is where Rails migrations will run

set :deploy_to, "/var/www/vhosts/blackartstudios.net/subdomains/wall/rails/StoryHub"

#role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end