default_run_options[:pty] = true
set :repository,  "git@github.com:tbbooher/polco.git"
set :scm, "git"
set :scm_passphrase, "polco111" #This is your custom users password
set :user, "deployer"


load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks