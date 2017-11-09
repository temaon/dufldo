source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc2', '< 5.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby'

gem 'nokogiri'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

#Solr-powered search for Ruby objects http://sunspot.github.com/
gem 'sunspot_rails'

group :development do
  gem 'letter_opener'
  gem 'letter_opener_web', '~> 1.2.0'
  gem 'sunspot_solr'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  ##============================================##
  gem 'rubycritic', require: false
  gem 'pry-rails'
end

gem 'listen', '~> 3.0.5'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


# Application

#Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'

#RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data
gem 'remotipart', github: 'mshibuya/remotipart'
gem 'rails_admin', git: 'https://github.com/sferik/rails_admin.git'
# gem 'rails_admin_flatly_theme', github: 'konjoot/rails_admin_flatly_theme'
gem 'rails_admin_rollincode', '~> 1.0'
gem 'ckeditor', '4.2.0'

#A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts. http://mbleigh.lighthouseapp.com/projects/10116-acts-as-taggable-on
gem 'acts-as-taggable-on', '~> 4.0'
#ActsAsTaggableOn tag_list field factory for rails_admin
gem 'rails_admin_tag_list', git: 'https://github.com/kryzhovnik/rails_admin_tag_list.git', branch: 'master'

#Haml-rails https://github.com/indirect/haml-rails
gem 'haml-rails'

#An awesome replacement for acts_as_nested_set and better_nested_set.
gem 'awesome_nested_set'
gem 'rails_admin_nested_set', '0.5.3'
# Easy to use integration of drag&drop files upload via dropzone.js for rails_admin
gem 'rails_admin_dropzone', '~> 1.0', '>= 1.0.5'
#Easy file attachment management for ActiveRecord https://thoughtbot.com/open-source
gem 'paperclip', '~> 5.0.0'
#Jcrop plugin for RailsAdmin, enable image cropping function on image fields.
# gem 'rails_admin_jcrop' #, git: 'git://github.com/janx/rails_admin_jcrop.git'
#Translations for the rails_admin gem
gem 'rails_admin-i18n'

#A modern, simple and very fast Mysql library for Ruby - binding to libmysql http://github.com/brianmario/mysql2
gem 'mysql2', '0.4.4'

#A Scope & Engine based, clean, powerful, customizable and sophisticated paginator
gem 'kaminari', github: 'amatsuda/kaminari', branch: '0-17-stable'

#Role management library with resource scoping http://rolifycommunity.github.com/rolify/
gem 'rolify'

#Advanced seed data handling for Rails, combining the best practices of several methods together.
gem 'seed-fu', '~> 2.3'
#Rails 4/5 task to dump your data to db/seeds.rb
gem 'seed_dump'

gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'
gem 'draper', github: 'drapergem/draper'

#Official Sass port of Bootstrap 2 and 3. http://getbootstrap.com/css/#sass
gem 'bootstrap-sass', '~> 3.3.6'

#Some [hopefully] useful extensions to Ruby’s String class. It is made up of three libraries: ActsAsUrl [permalink solution with better character translation], Unidecoder [Unicode to Ascii transliteration], and StringExtensions [miscellaneous helper methods for the String class].
gem 'stringex', '~> 2.6.1'

gem 'mina',  '0.3.8'

#A Rails engine for comments
gem 'commontator', '~> 4.10.1'

#Rails Plugin that tracks impressions and page views
gem 'impressionist'

#This gem packages the bootstrap-datetimepicker for the Rails 3.1+ asset pipeline.
gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails', :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'

#underscore.js asset-pipeline provider/wrapper
gem 'underscore-rails'
