class WelcomeController < ApplicationController
  layout 'guest'
  skip_before_filter :authenticate
end
