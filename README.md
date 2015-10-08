#Sinatra Web Server
## Repo details
| Details   |  | 
| :--------------- | -------: |
| Re-created by: | Holloway, Chew Kean Ho |
| Version:    | See Master Branch Version Number   |
| Contribution:    | Hobby. Best effort basis.   |
<br><br>
## Purpose
This Ruby Sinatra web skeleton was re-furbished for rapid prototyping a web API before deploying to rails server. It's referenced from Rails file structure with mild tweaking and CodeDivision Sinatra skeleton.
<br><br>
##Supports
1. Local Support
2. Bluemix Support - using PUMA

>**NOTE**:
>This guide assumes you are good with Ruby, Heroku, Bluemix and understands MVC architecture patterns.

<br><br>
## Common Setup
1) Perform a git clone to this repo using the following link:
```
# http
$ git clone -b bluemix https://github.com/hollowaykeanho/sinatra-web-server.git

# ssh
$ git clone -b bluemix git@github.com:hollowaykeanho/sinatra-web-server.git
```
2)  Rename the skeleton if needed
```
$ mv sinatra-web-server <your-desired-app-name>
```
3) Enter into the skeleton and perform bundle install
```
$ cd <your-desired-app-name>
$ bundle install  
# Open issue in this github repo if any issue
```
4) Perform a short test by launching the server
```
$ rake server
```
5) Hooray! You may now begin your code development.
<br><br>

## How To Use
The skeleton is primarily based on Rails file structure with focus towards MVC architectural pattern. However, unlike Rails, this skeleton is to provide more structural freedom for you to prototype or to bootstrap and idea quickly. The flexibility is up to deploying the app in Bluemix.
<br>
### To Launch the Server
Rakefile has a simplified command for launching the server in development mode. To perform, execute:
```
$ rake server
```
<br><br>

### To Include/Remove a Gem
1) Include/remove your gem inside Gemfile depending on group. Please note that Heroku will use production only.
```
# File location: <repo_root>\Gemfile
```
2) Perform bundle install
```
$ bundle install
```
3) Head to **config\environments\init.rb** to ensure your require is aligned to your adjustment.
```
# Perform requiring gem that we need
#######################################################
	# basic
require 'rubygems'
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'pathname'

	# database
require 'pg'
require 'active_record'
require 'logger'

	# sinatra
require 'sinatra'
require "sinatra/reloader" if development?

	# embedded ruby
require 'erb'
require 'uri'

	# Additional Gem includes after this comments
#######################################################
```
4) Done. You're ready. 
<br><br>

### To Create Controller
You can create a controller ruby file inside **app/controllers** manually. As long as there is no conflicted routes, you can create many controller files. Sinatra go through each controller file and compile all available route.

In this example, let's create 'sessions' routing:
```
# app/controllers/users.rb

get '/signup' do
	erb :'users/new'
end

post '/signup' do
	# Do something processing with user input
	redirect to '/user/dashboard'
end

get '/user/dashboard' do
	erb :dashboard
end
```
<br>
### To Create Views
You can create a view erb file inside **app/views** manually. This framework uses erb gem to generate the view. Views can be created in full-form or partial-form. Examples,
#### To create simple erb view file:
```
# app/views/root.erb
<h1>This is root page</h1>
...
# To route it, use ' erb :root ' in controller
```
#### To create erb view file inside a sub-folder:
```
# app/views/users/new.erb
<h1>This is signup page</h1>
...
# To route it, use ' erb :"users/new" ' in controller
```
#### To create partial erb view file:
```
# app/views/partials/form.erb
<h1>This is partial forms for AJAX calls</h1>
...


# To use it in existing view .erb file, example:
	# in app/views/users/new.erb
	<h2> User Data </h2>
	<%= erb :"partial/form" %>
```
<br><br>

### To Create Model
Model creation is supported by Rakefile. To create, simply execute:
```
$ rake generate:model NAME=<singular_model_name>
```
>**NOTE**:
> Due to maintaining structural freedom, rake will only create model file and **not** with database migration file. You're expected to handle database migration file separately.

<br><br>

### To Create Helper
Helper file can be created inside **app/helpers** manually and at will. To ensure the functions are working in the helpers, any helper file should has the helpers loop. Example:
```
# app/helpers/html.rb
helpers do
	# for repetitive <em> in html view
	def em(param)
		...
	end

	# for repetitive math calculation
	def calculate_square(param)
		param * param
	end
	
	# More repetitive functions
	...
end
```
<br>
Any function within helpers loop can be called directly like a Ruby modules' methods. Example:
```
# app/controllers/root.rb
post '/' do
	calculate_square(params[:input])
end

# app/views/root.erb
<html>
	...
	<%= em("String") %>
	...
</html>
```
More information can be found here: http://www.sinatrarb.com/faq.html#helpview
<br><br>

### To Create Database
Database creation is supported by Rakefile. To create, execute:
```
$ rake db:create
```
<br><br>

### To Create Database Migration File
Database migration file creation is supported by Rakefile. To create, execute:
```
$ rake generate:migration NAME=<filename>
```
>**REMEMBER**: 
>------be careful with ActiveRecord **naming convention** especially singular/plural!

<br><br>

### To Perform Database Migration
Database migration is supported by Rakefile. To perform, execute:
```
$ rake db:migrate
```
<br><br>

### To Drop Database
Database migration is supported by Rakefile. To perform, execute:
```
$ rake db:drop
```
<br><br>

### To Seed Data into Database
Database data seeding is supported by Rakefile. To perform, execute:
```
$ rake db:seed
```
<br><br>

### To View Current Database Migration Version
Database current migration version view is supported by Rakefile. To perform, execute:
```
$ rake db:version
```
<br><br>

### Push to Bluemix
>**NOTE**:
>This section assumes you have CF Toolbelt installed inside your local computer. Goto https://www.ng.bluemix.net/docs/starters/install_cli.html to begin your installation.

1) Perform API linking. If you have done this, skip to step (2). 
```
$ cf api https://api.ng.bluemix.net
```
<br>
2) Login into your CF.
```
$ cf login -u <user_name> -o <organization_name> -s <space_name>
# E.g.:
$ cf login -u hollowaykeanho@gmail.com -o hollowaykeanho@gmail.com -s dev
```
<br>
3) Create a database for your app.
```
$ cf create-service elephantsql turtle <service_name>
# E.g.: (by naming service_name as my app_name for easy management)
$ cf create-service elephantsql turtle sinatra-web-server
```
<br>
4) Bind the database server.
```
$ cf bind-service <app_name> <service_name>
# E.g.:
$ cf bind-service sinatra-web-server sinatra-web-server
```
<br>
5) Generate a manifest.yml file based on latest settings
```
$ bundle exec rake generate:bluemix_manifest OPTION=<option_availble>
$ git add manifest.yml
$ git commit -m <commit_message>
# E.g.:
$ bundle exec rake generate:bluemix_manifest OPTION="free"
$ git add manifest.yml
$ git commit -m "updated manifest.yml to current apps settings"
```
<br>
6) Read and Export the DATABASE_URL environment variables
```
$ cf env <app_name>
# Take note of the URI which gives the postgres URI. That is your DATABASE_URL.
$ cf set-env <app_name> DATABASE_URL <database_url>

# E.g:
$ cf env sinatra-web-server
Getting env variables for app sinatra-web-server in org user@email.com / space dev as user@email.com...
OK

System-Provided:
{
 "VCAP_SERVICES": {
  "elephantsql": [
   {
    "credentials": {
     "max_conns": "5",
     "uri": "postgres://npljhvnk:fD6HbSpWIm-KUXUYVGdOsjMyz3UFc0p3@qdjjtnkv.db.elephantsql.com:5432/npljhvnk"
    },
    ...
}

$ cf set-env sinatra-web-server DATABASE_URL postgres://npljhvnk:fD6HbSpWIm-KUXUYVGdOsjMyz3UFc0p3@qdjjtnkv.db.elephantsql.com:5432/npljhvnk
```
<br>
7) Push to Bluemix Server
```
$ cf push <app_name>
# E.g.:
$ cf push sinatra-web-server
```
<br><br>

## Important Notice
CF only recognizes progressive development. Hence, please avoid using git amend or git rebase to alter history. Otherwise, your app will not work and requires you to delete and restart again.

## Special Thanks
1. CodeDivision for their code bootcamp training.
2. Josh who motivated me to re-code this framework.
3. All friends and teams in CodeDivision.
4. Justin for helping up enabling the Bluemix support.
<br><br>

## References
1. http://www.blacktm.com/talks/building_web_apps_with_rack_and_sinatra/#simple_rack
2. http://www.sinatrarb.com/intro.html#Environments
3. http://nycda.com/blog/integrating-activerecord-into-a-sinatra-project/
4. http://rake.rubyforge.org/
5. http://recipes.sinatrarb.com/p/development/bundler
6. https://robots.thoughtbot.com/test-rake-tasks-like-a-boss
7. http://apidock.com/rails/String/singularize
8. http://code.tutsplus.com/tutorials/how-to-integrate-rspec-into-a-sinatra-app--net-21564
9. http://www.millwoodonline.co.uk/blog/mini-minitest-tutorial
10. http://www.sinatrarb.com/configuration.html
11. https://devcenter.heroku.com/articles/getting-started-with-ruby-o
12. https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
13. https://blog.codeship.com/puma-vs-unicorn/
14. https://devcenter.heroku.com/articles/getting-started-with-rails3
15. http://www.getlaura.com/how-to-enable-sessions-with-sinatra/
16. http://stackoverflow.com/questions/5693528/how-to-use-sinatra-session
17. https://www.ng.bluemix.net/docs/starters/install_cli.html
18. https://docs.cloudfoundry.org/devguide/services/migrate-db.html#frequent-migration
19. https://docs.cloudfoundry.org/buildpacks/ruby/ruby-tips.html#rake
20. http://docs.run.pivotal.io/devguide/deploy-apps/environment-variable.html
