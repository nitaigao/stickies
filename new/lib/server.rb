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
  session[:open_id]
end

get '/' do
  open_id
  haml :index
end

get '/login/?' do
  haml :login
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
      user = User.first(:open_id => response.display_identifier) || User.create({:open_id => response.display_identifier, :nickname => params['openid.sreg.nickname']})      
      session[:open_id] = user.open_id
      redirect '/dashboard'
  end  
end

get '/dashboard/?' do
  user = User.first(:open_id => open_id)
  haml :dashboard, :locala => { :walls => user.walls }
end

post '/login/?' do  
  response = consumer.begin(params[:openid])
  response.add_extension_arg('sreg','required','nickname,email')
  openid_url = response.redirect_url('', 'http://localhost:9393/loggedin')
  redirect openid_url
end