require File.join(File.dirname(__FILE__), *%w[lib server])

use(Rack::Reloader, 0) if ENV["RACK_ENV"] == "development"
run(StoryHub)
