require 'rubygems'
require 'sinatra'
require 'haml'
require 'restclient'
require 'json'
require "sass/plugin/rack"
require "sequel"

require "openid"
require "openid/store/filesystem"

DB = Sequel.connect("mysql://localhost/storyhub_dev?user=root")

require File.join(File.dirname(__FILE__), "user")
require File.join(File.dirname(__FILE__), "wall")
require File.join(File.dirname(__FILE__), "column")
require File.join(File.dirname(__FILE__), "story")

configure do
  enable :sessions
  
  set :views, File.expand_path(File.join(File.dirname(__FILE__), '..', 'views'))
  set :public, File.expand_path(File.join(File.dirname(__FILE__), '..', 'public'))
  set :haml, { :attr_wrapper => '"' }
  set :root, File.dirname(__FILE__)

  use Sass::Plugin::Rack
end

def consumer
  @consumer ||= OpenID::Consumer.new(session, OpenID::Store::Filesystem.new("#{File.dirname(__FILE__)}/tmp/openid"))  
end

def open_id
  redirect '/login' if !session.has_key?(:open_id)
#  redirect '/login' if not User[session[:open_id]]  
  session[:open_id]
end

def user
  User.first(:open_id => open_id)
end

get '/' do
  open_id
  haml :index
end

get '/login/?' do
  haml :login
end

post '/login/?' do  
  response = consumer.begin(params[:openid])
  response.add_extension_arg('sreg','required','nickname,email')
  openid_url = response.redirect_url('', 'http://localhost:9393/loggedin')
  redirect openid_url
end

get '/loggedin/?' do
  response = consumer.complete(params, request.url)
  
  case response.status
    when OpenID::Consumer::FAILURE
      "Sorry, we could not authenticate you with the identifier '{openid}'."

    when OpenID::Consumer::SETUP_NEEDED 
      "Immediate request failed - Setup Needed"

    when OpenID::Consumer::CANCEL
      "Login cancelled."

    when OpenID::Consumer::SUCCESS
      new_user = User.first(:open_id => response.display_identifier) || User.create({:open_id => response.display_identifier, :nickname => params['openid.sreg.nickname']})      
      session[:open_id] = new_user.open_id
      redirect '/dashboard'
  end  
end

get '/dashboard/?' do
  haml :dashboard, :locala => { :walls => user.walls }
end

get '/walls/new/?' do
  haml :new_wall
end

post '/walls/new/?' do
  wall = Wall.create(params[:new_wall])
  wall.add_user(user)
  wall.save
  redirect("/walls/#{wall.name}/")
end

get '/walls/:name/?' do
  user = User.first(:open_id => open_id)
  redirect('/dashboard/') if user.walls.reject { |wall| wall.name != params[:name] }.empty?
  haml :wall, :locals => { :wall => user.walls.select { |wall| wall.name == params[:name] }.first }
end

get '/walls/:name/admin/?' do
  redirect('/dashboard/') if user.walls.reject { |wall| wall.name != params[:name] }.empty?
  haml :admin, :locals => { :wall => user.walls.select { |wall| wall.name == params[:name] }.first }
end 

post '/walls/:name/columns/new/?' do
  column = Column.create(params[:new_column])
  wall = user.walls.select { |wall| wall.name == params[:name] }.first
  wall.add_column(column)
  wall.save
  redirect("/walls/#{params[:name]}/admin/")
end

delete '/walls/:name/columns/:column_id/?' do
  wall = user.walls.select { |wall| wall.name == params[:name] }.first
  column = wall.columns.select{|column| column.id == params[:column_id].to_i}.first
  column.delete
  redirect("/walls/#{params[:name]}/admin/")
end

get '/walls/:wall_name/columns/:column_id/stories/new' do
  haml :new_story, :locals => { :wall_name => params[:wall_name], :column_id => params[:column_id] }
end

post '/walls/:wall_name/columns/:column_id/stories/new' do
  wall = user.walls.select { |wall| wall.name == params[:wall_name] }.first
  column = wall.columns.select{|column| column.id == params[:column_id].to_i}.first
  story = Story.create(params[:new_story])
  column.add_story(story)
  column.save
  redirect("/walls/#{wall.name}/")
end

delete '/walls/:wall_name/columns/:column_id/stories/:story_id' do
  wall = user.walls.select { |wall| wall.name == params[:wall_name] }.first
  column = wall.columns.select{|column| column.id == params[:column_id].to_i}.first
  story = column.stories.select{|story| story.id == params[:story_id].to_i}.first
  story.delete
  redirect("/walls/#{wall.name}/")
end