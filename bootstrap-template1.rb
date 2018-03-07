# spring stop && rm -rf $(ls) && rm -rf .git && rm -rf .gitignore && rails new . -d postgresql -M -C -T --skip-turbolinks -m ~/RubymineProjects/templates/bootstrap-template.rb && rails s

# Если вам просто нужен Slim
gem 'slim'
# Если вам нужен Slim и генераторы Scaffold'ов
gem 'slim-rails', group: :development
gem 'html2slim', group: :development

gem 'jquery-rails'
gem 'bootstrap-sass'

# devise_installed = yes?("Do you want install devise?")
# if devise_installed
#   gem 'devise'
# end

run 'for file in app/views/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done'

generate :controller, "home", "index"
route "root to: 'home#index'"


# after_bundle do
#   puts File.join(__dir__, 'src', 'application.js')
#   puts path = File.join(__dir__, '.rbenv-gemsets')
#   puts File.read(path)
#   # puts File.dirname(__FILE__)
# end

gsub_file 'app/assets/javascripts/application.js', '//= require rails-ujs', File.read(File.join(__dir__, 'src', 'application.js'))
# gsub_file 'app/assets/javascripts/application.js', '//= require rails-ujs', <<-'CODE'
# //= #require rails-ujs
# //= require jquery
# //= require jquery_ujs
# //= require bootstrap-sprockets
# CODE
#
#
#
# file 'app/assets/stylesheets/custom.css.scss', <<-'CODE'
# @import "bootstrap-sprockets";
# @import "bootstrap";
#
#
# body {
#   padding-top: 50px;
#   padding-bottom: 20px;
# }
# CODE
#
#
#
# file 'app/views/layouts/_notice_alert.html.slim', <<-'CODE'
# .row
#   .col-sm-8.col-sm-offset-2
#     - if notice
#       br
#       .alert.alert-success.alert-dismissible role="alert"
#         button.close type="button" data-dismiss="alert" aria-label="Close"
#           span aria-hidden="true" &times;
#         = notice
#     - if alert
#       br
#       .alert.alert-warning.alert-dismissible role="alert"
#         button.close type="button" data-dismiss="alert" aria-label="Close"
#           span aria-hidden="true" &times;
#         = alert
# CODE
#
#
#
# file 'app/views/layouts/_navbar.html.slim', <<-'CODE'
# .navbar.navbar-fixed-top.navbar-default
#   .container-fluid
#     .navbar-header
#       button.navbar-toggle type="button" data-toggle="collapse" data-target=".navbar-collapse"
#         span.icon-bar
#       = link_to 'APP_NAME', root_path, class: "navbar-brand"
#     .navbar-collapse.collapse
#       ul.nav.navbar-nav
#         li = link_to 'Домашняя страница', root_path
# CODE
#
#
#
# gsub_file 'app/views/layouts/application.html.slim', '    = yield', <<-'CODE'
#     = render 'layouts/navbar'
#     .container
#       = render 'layouts/notice_alert'
#       = yield
# CODE
#
#
#
# comment_lines 'config/database.yml', '  database:'
# comment_lines 'config/database.yml', '  username:'
# comment_lines 'config/database.yml', '  password:'
# # comment_lines 'config/database.yml', '  timeout'
# inject_into_file 'config/database.yml', after: '  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>' do <<-CODE
#
#   host:     <%= ENV.fetch('DB_HOST', '') %>
#   username: <%= ENV.fetch('DB_USER', '') %>
#   password: <%= ENV.fetch('DB_PWD', '') %>
#   database: <%= ENV.fetch('DB_NAME', '') %>
# CODE
# end
# # gsub_file 'config/database.yml', '  adapter: sqlite3', '  adapter: postgresql'
#
#
#
# open('.gitignore', 'a') do |f|
#   f.puts ''
#   f.puts '.idea'
#   f.puts '.rbenv-vars'
#   f.puts 'public/assets'
# end
#
#
#
# file 'config/locales/ru.yml', <<-'CODE'
# ru:
#   hello: "Добрый день"
#   login: "Вход"
#   user: "Пользователь"
#   password: "Пароль"
#   remember_me: "Запомнить меня"
#   log_in: "Войти"
#   devise:
#     failure:
#       user:
#         unauthenticated: "Вы должны войти, прежде чем продолжить."
#         timeout: "Ваша сессия истекла. Пожалуйста, авторизуйтесь, чтобы продолжить."
#         invalid: "Неверное имя пользователя или пароль."
#     sessions:
#       user:
#         signed_in: "Добро пожаловать."
#         signed_out: "Вы успешно завершили сессию."
#
# CODE
# inject_into_file 'config/application.rb', after: 'config.generators.system_tests = nil' do <<-'CODE'
#
#     config.i18n.default_locale = :ru
# CODE
# end
#
#
#
# after_bundle do
#   # git :init
#   git add: '.'
#   git commit: "-a -m 'init'"
#
# if devise_installed and yes?("Do you want setup devise?")
#   rails_command 'db:drop'
#   generate 'devise:install'
#   generate 'devise', 'User'
#
#
#
#   devise_migration_file = Dir.glob('db/migrate/*_devise_create_users.rb').first
#   comment_lines devise_migration_file, 't.string   :reset_password_token'
#   comment_lines devise_migration_file, 't.datetime :reset_password_sent_at'
#   comment_lines devise_migration_file, 'add_index :users, :reset_password_token, unique: true'
#   gsub_file devise_migration_file, '""', '\'\''
#   inject_into_file devise_migration_file, before: '      t.string :email' do <<-'CODE'
#       t.string  :login,              null: false, default: ''
#       t.boolean :admin,              null: false, default: false
#       t.string  :username,           null: false, default: ''
# CODE
#
#   end
#   inject_into_file devise_migration_file, after: '    add_index :users, :email,                unique: true' do
#     "\n    add_index :users, :login,                unique: true"
#   end
#   # comment_lines devise_create_users_migration_file, 'devise'
#   # comment_lines devise_create_users_migration_file, ':recoverable'
#   gsub_file 'app/models/user.rb', "  devise :database_authenticatable, :registerable,\n         :recoverable, :rememberable, :trackable, :validatable", <<-'CODE'
#   devise :database_authenticatable,
#          # :registerable,
#          # :recoverable,
#          # :validatable,
#          :rememberable,
#          :trackable
# CODE
#
#
#
#   gsub_file 'config/initializers/devise.rb', '# config.authentication_keys = [:email]', 'config.authentication_keys = [:login]'
#   gsub_file 'config/initializers/devise.rb', 'config.case_insensitive_keys = [:email]', 'config.case_insensitive_keys = [:login]'
#   gsub_file 'config/initializers/devise.rb', 'config.strip_whitespace_keys = [:email]', 'config.strip_whitespace_keys = [:login]'
#
#
#
#   rails_command 'db:setup'
#   rails_command 'db:migrate'
#
#
#
#   open('db/seeds.rb', 'a') do |f|
#     f.puts <<-'CODE'
#
# unless User.where(login: 'admin').exists?
#   User.create!({login: 'admin', admin: true, password: 'admin', password_confirmation: 'admin', username: 'admin', email: 'admin@mail.com' })
# end
#
# unless User.where(login: 'user').exists?
#   User.create!({login: 'user', admin: false, password: 'user', password_confirmation: 'user', username: 'user', email: 'user@mail.com'})
# end
# CODE
#   end
#   rails_command 'db:seed'
#
#
#
#   # generate 'devise:views -v sessions'
#   # run 'for file in app/views/devise/**/*.erb; do erb2slim $file ${file%erb}slim && rm $file; done'
#   file 'app/views/devise/sessions/new.html.slim', <<-'CODE'
# = form_for(resource, as: resource_name, url: session_path(resource_name), html: { class: 'form-single' }) do |f|
#   h1.form-signin-heading = t('login')
#   .field
#     = f.label :login, class: 'sr-only'
#     = f.text_field :login, autofocus: true, class: 'first form-control', placeholder: t('user')
#     = f.label :password, class: 'sr-only'
#     = f.password_field :password, autocomplete: 'off', class: 'last bottom form-control', placeholder: t('password')
#   - if devise_mapping.rememberable?
#     .field
#       .checkbox
#         = f.label :remember_me do
#           = f.check_box :remember_me
#           span = t('remember_me')
#   .actions
#     = f.submit t('log_in'), class: 'btn btn-lg btn-primary btn-block'
#
# CODE
#
#   file 'app/assets/stylesheets/login.scss', <<-CODE
# .form-single {
#   background: #FDFDFD;
#   border-radius: 5px;
#   border: 1px solid grey;
#   margin: 50px auto 0 auto;
#
#   max-width: 425px;
#   padding: 15px;
#   h1 {
#     padding: 0px 0 20px 0;
#   }
#   text-align: center;
#   .logo {
#     padding-top: 10px;
#     width: 150px;
#     height: 150px;
#   }
#   .form-signin-heading {
#     text-align: center;
#   }
#   .form-signin-heading,
#   .checkbox {
#     margin-bottom: 10px;
#   }
#   .checkbox {
#     font-weight: normal;
#     input {
#       width: inherit;
#     }
#   }
#   .form-control {
#     position: relative;
#     height: auto;
#     -webkit-box-sizing: border-box;
#     -moz-box-sizing: border-box;
#     box-sizing: border-box;
#     padding: 10px;
#     font-size: 16px;
#   }
#   .form-control:focus {
#     z-index: 2;
#   }
#   input.bottom {
#     margin-bottom: 10px;
#   }
#   input.middle {
#     border-radius: 0;
#   }
#   input.first {
#     margin-bottom: -1px;
#     border-bottom-right-radius: 0;
#     border-bottom-left-radius: 0;
#   }
#   input.last {
#     border-top-left-radius: 0;
#     border-top-right-radius: 0;
#   }
# }
# .form-change-password .field-error {
#   text-align: left;
# }
# CODE
#   inject_into_file 'app/controllers/application_controller.rb', before: 'end' do <<-'CODE'
#   before_action :authenticate_user!
# CODE
#   end
#
#
#
#   open('app/views/layouts/_navbar.html.slim', 'a') do |f|
#     f.puts <<-'CODE'
#
#       ul.nav.navbar-nav.navbar-right
#         li.dropdown
#           a.dropdown-toggle data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"
#             = user_signed_in? ? "#{current_user.try(:username)}" : 'Вход'
#             span.caret<
#           ul.dropdown-menu
#             /li
#               /= link_to('Users', users_path) if current_user.try(:admin?)
#             li
#               - if user_signed_in?
#                 = link_to 'Выход', destroy_user_session_path, method: :delete
#               - else
#                 = link_to 'Вход', new_user_session_path
# CODE
#
#   end
#
#
#
#   git add: '.'
#   git commit: "-a -m 'Add devise'"
# end
# end
