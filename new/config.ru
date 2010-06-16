require File.join(File.dirname(__FILE__), *%w[lib server])

map '/' do
  run Sinatra::Application
end
