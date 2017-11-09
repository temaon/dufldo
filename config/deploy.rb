require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'


# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, '185.25.116.100'
set :user, 'dufldo'
set :deploy_to, "/home/#{user}/app"
set :repository, 'git@bitbucket.org:tema_on/new_ffgd.git'
set :branch, 'master'

set :rvm_path, '$HOME/.rvm/scripts/rvm'
set :rails_env, 'production'
# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log', 'public/system', 'config/sunspot.yml']

# Puma settings
set :puma_bind,       "unix://#{deploy_to}/tmp/sockets/dufldo.sock"
set :puma_state,      "#{deploy_to}/tmp/pids/puma.state"
set :puma_pid,        "#{deploy_to}/tmp/pids/puma.pid"
set :puma_access_log, "#{deploy_to}/log/puma.error.log"
set :puma_error_log,  "#{deploy_to}/log/puma.access.log"


# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  ruby_version = File.read('.ruby-version').strip
  invoke :"rvm:use[#{ruby_version}@ffgd]"
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/public"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/system"]

  # Add the repository server to .ssh/known_hosts
  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %[
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    ]
  end
  
  # Create database.yml for Mysql2 if it doesn't exist
  path_database_yml = "#{deploy_to}/#{shared_path}/config/database.yml"
  database_yml = %[production:
  database: #{user}
  adapter: mysql2
  encoding: utf8
  pool: 5
  timeout: 5000]
  queue! %[ test -e #{path_database_yml} || echo "#{database_yml}" > #{path_database_yml} ]
  
  # Create secrets.yml if it doesn't exist
  path_secrets_yml = "#{deploy_to}/#{shared_path}/config/secrets.yml"
  secrets_yml = %[production:
  secret_key_base:
    #{`rake secret`.strip}]
  queue! %[ test -e #{path_secrets_yml} || echo "#{secrets_yml}" > #{path_secrets_yml} ]
  
  queue! %[chmod g+rx,u+rwx,o-rwx "#{deploy_to}/#{shared_path}/config"]

end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile:force'
    invoke :'deploy:cleanup'
    invoke :'puma:make_dirs'

    to :launch do
      invoke :'puma:restart'
      # queue "rails server -d"
    end
  end
end

namespace :puma do
  desc 'Restart the application'
  task :restart do
    queue 'echo "-----> Restart Puma"'
    # queue "bundle exec 'puma start -b #{puma_bind} -e #{rails_env} --pidfile=#{deploy_to}/tmp/pids/dufldo.pid -d'"
    queue "fuser -k 3000/tcp"
    queue "bundle exec rails s -e production -d"
    # queue "RAILS_ENV=production bundle exec rails sunspot:solr:start"
    # queue "RAILS_ENV=production bundle exec rails sunspot:reindex"
  end

  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    queue "mkdir ~/app/tmp/sockets -p"
    queue "mkdir ~/app/tmp/pids -p"
    queue "mkdir ~/app/tmp/log -p"

    queue "mkdir -p #{deploy_to}/solr/data"
    queue "rm -rf #{deploy_to}/solr/data"
  end

end

