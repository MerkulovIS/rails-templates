# Если вам просто нужен Slim
gem 'slim'
# Если вам нужен Slim и генераторы Scaffold'ов
gem 'slim-rails', group: :development
gem 'html2slim', group: :development

gem 'jquery-rails'
gem 'bootstrap-sass'

devise_installed = yes?('Do you want install devise?')
if devise_installed
  gem 'devise'
end

run 'for file in app/views/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done'

generate :controller, 'home', 'index'
route "root to: 'home#index'"


def from_src(file)
  File.read(File.join(__dir__, 'src', file))
end


gsub_file 'app/assets/javascripts/application.js', '//= require rails-ujs', from_src('application.js')
file 'app/assets/stylesheets/custom.css.scss', from_src('custom.css.scss')
file 'app/views/layouts/_notice_alert.html.slim', from_src('_notice_alert.html.slim')
file 'app/views/layouts/_navbar.html.slim', from_src('_navbar.html.slim')
gsub_file 'app/views/layouts/application.html.slim', '    = yield', from_src('application.html.slim')


comment_lines 'config/database.yml', '  database:'
comment_lines 'config/database.yml', '  username:'
comment_lines 'config/database.yml', '  password:'
# comment_lines 'config/database.yml', '  timeout'
inject_into_file 'config/database.yml', after: '  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>' do
  from_src('database.yml')
end
# gsub_file 'config/database.yml', '  adapter: sqlite3', '  adapter: postgresql'


open('.gitignore', 'a') do |f|
  f.puts ''
  f.puts '.idea'
  f.puts '.rbenv-vars'
  f.puts 'public/assets'
end


file 'config/locales/ru.yml', from_src('ru.yml')
inject_into_file 'config/application.rb', after: 'config.generators.system_tests = nil' do
  "\n    config.i18n.default_locale = :ru"
end


after_bundle do
  # git :init
  git add: '.'
  git commit: "-a -m 'init'"

  if devise_installed and yes?('Do you want setup devise?')
    rails_command 'db:drop'
    generate 'devise:install'


    generate 'devise', 'User'
    devise_migration = Dir.glob('db/migrate/*_devise_create_users.rb').first
    comment_lines devise_migration, 't.string   :reset_password_token'
    comment_lines devise_migration, 't.datetime :reset_password_sent_at'
    comment_lines devise_migration, 'add_index :users, :reset_password_token, unique: true'
    gsub_file devise_migration, '""', '\'\''
    inject_into_file devise_migration, before: '      t.string :email' do
      from_src('devise_migration.rb')
    end
    inject_into_file devise_migration, after: '    add_index :users, :email,                unique: true' do
      "\n    add_index :users, :login,                unique: true"
    end
    # comment_lines devise_migration, 'devise'
    # comment_lines devise_migration, ':recoverable'
    devise_model = [
      '  devise :database_authenticatable, :registerable,',
      '         :recoverable, :rememberable, :trackable, :validatable'
    ].join("\n")
    gsub_file 'app/models/user.rb', devise_model, from_src('user.rb')


    gsub_file 'config/initializers/devise.rb',
              '# config.authentication_keys = [:email]', 'config.authentication_keys = [:login]'
    gsub_file 'config/initializers/devise.rb',
              'config.case_insensitive_keys = [:email]', 'config.case_insensitive_keys = [:login]'
    gsub_file 'config/initializers/devise.rb',
              'config.strip_whitespace_keys = [:email]', 'config.strip_whitespace_keys = [:login]'


    rails_command 'db:setup'
    rails_command 'db:migrate'


    open('db/seeds.rb', 'a') do |f|
      f.puts from_src('seeds.rb')
    end
    rails_command 'db:seed'


    # generate 'devise:views -v sessions'
    # run 'for file in app/views/devise/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done'
    file 'app/views/devise/sessions/new.html.slim', from_src('new.html.slim')
    file 'app/assets/stylesheets/login.scss', from_src('login.scss')
    inject_into_file 'app/controllers/application_controller.rb', before: 'end' do
      "  before_action :authenticate_user!\n"
    end


    open('app/views/layouts/_navbar.html.slim', 'a') do |f|
      f.puts from_src('_navbar_devise.html.slim')
    end


    git add: '.'
    git commit: "-a -m 'Add devise'"
  end
end
