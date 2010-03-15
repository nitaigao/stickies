require 'test_helper'

class SignupControllerTest < ActionController::TestCase
  test "it should error if the user already exists" do
    post :create, { :user => { :email => 'real@user.com', :password => 'password' } }
    assert_redirected_to :action => 'exists'
  end
  
  test "it should forward to the dashboard if the user has been created" do
    post :create, { :user => { :email => 'nonexisting@user.com', :password => 'password' } }    
    assert_redirected_to :controller => 'projects'
  end
end
