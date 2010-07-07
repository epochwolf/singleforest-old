set :application, "singleforest"
set :repository, "file:///srv/git/singleforest.git" 
set :local_repository, "file://."
set :deploy_via, :export
set :scm, :git
set :user, "sf"
set :use_sudo, false

#cap doesn't like compression... BOOHISS
ssh_options[:compression] = "none" 

#set :uploads_dirs,    %w(public/uploads db/shared)
#set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/apps/#{application}"

server "singleforest.com", :app, :web, :db, :primary => true



# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do end
  task :stop do end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  after "deploy:setup", "deploy:shared:setup"
  after "deploy:symlink", "deploy:shared:symlink"

  namespace :shared do
    folders = %w(public/uploads db/shared)
    
    desc "Create the dirs in shared path."
    task :setup do
      folders.each do |folder|
        run "mkdir -p  #{shared_path}/#{folder}"
      end
    end

    desc "Link dir from shared to common."
    task :symlink do
      folders.each do |folder|
        run "rm -rf #{current_path}/#{folder}; ln -s #{shared_path}/#{folder} #{current_path}/#{folder}"
      end
    end

  end
end