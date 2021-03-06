require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :repository, "git@github.com:joshuamcadams/cms.git"
set :branch, 'master'
set :deploy_to, "/var/www/simple_cms"
set :app_path, "/var/www/simple_cms/current"
set :forward_agent, true
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log', 'tmp']

task :production do
  set :user, 'deploy'
  set :domain, "104.236.177.212"
  set :port, 22
  set :stage, 'production'
end

task :environment do
  queue! %[export PATH="/usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH"]
end

task :setup => :environment do
  ['log', 'config', 'tmp/log', 'tmp/pids', 'tmp/sockets'].each do |dir|
    queue! %[mkdir -m 750 -p "#{deploy_to}/#{shared_path}/#{dir}"]
  end
end

task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'server:restart'
    end
  end
end

namespace :server do
  [:start, :stop, :restart].each do |action|
    task action do
      queue "cd #{app_path} && RAILS_ENV=#{stage} && bin/puma.sh #{action}"
    end
  end
end
