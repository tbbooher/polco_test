set :application, "polco"
load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true
set :repository,  "git@github.com:tbbooher/polco.git"
set :scm, "git"
#set :user, "deployer"

ssh_options[:forward_agent] = true
set :branch, "master"

set :git_shallow_clone, 1
set :git_enable_submodules, 1

set :stages, %w(production staging)
require 'capistrano/ext/multistage'
 
server "74.207.224.12", :app, :web, :db, :primary => true
 
set :user, 'root'
set :keep_releases, 3
set :use_sudo, false
set :deploy_via, :copy
 
# this will make sure that capistrano checks out the submodules if any
set :git_enable_submodules, 1
 
set(:application) { "polco_#{stage}" } # replace gitlearn with your application name
set (:deploy_to) { "/var/www/#{application}" }
set :copy_remote_dir, "/home/#{user}/tmp"
 
# source: http://tomcopeland.blogs.com/juniordeveloper/2008/05/mod_rails-and-c.html
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "invoke the db migration"
  task:migrate, :roles => :app do
    send(run_method, "cd #{current_path} && rake db:migrate RAILS_ENV=#{stage} ")
  end
  
end