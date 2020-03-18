# # config valid for current version and patch releases of Capistrano
# lock "~> 3.12.1"

# set :application, "my_app_name"
# set :repo_url, "git@example.com:me/my_repo.git"

# # Default branch is :master
# # ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# # Default deploy_to directory is /var/www/my_app_name
# # set :deploy_to, "/var/www/my_app_name"

# # Default value for :format is :airbrussh.
# # set :format, :airbrussh

# # You can configure the Airbrussh format using :format_options.
# # These are the defaults.
# # set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# # Default value for :pty is false
# # set :pty, true

# # Default value for :linked_files is []
# # append :linked_files, "config/database.yml"

# # Default value for linked_dirs is []
# # append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# # Default value for default_env is {}
# # set :default_env, { path: "/opt/ruby/bin:$PATH" }

# # Default value for local_user is ENV['USER']
# # set :local_user, -> { `git config user.name`.chomp }

# # Default value for keep_releases is 5
# # set :keep_releases, 5

# # Uncomment the following to require manually verifying the host key before first deploy.
# # set :ssh_options, verify_host_key: :secure



#👆👆ここから上は全てコメントアウトした👆👆



# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.12.1'

# Capistranoのログの表示に利用する
set :application, 'chat-space'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:MTKS-3254-KNT/chat-space'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/ChatSpase3254.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5
set :linked_files, %w{ config/secrets.yml }

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'upload secrets.yml'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end