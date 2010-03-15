require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  
  test "it should fail to login a user that doesnt exist" do        
    post :authenticate, { :login => {:email => 'test@test.com', :password => 'password'} }
    assert_redirected_to :action => 'failure'     
  end
  
  test "it should login a user that exists" do        
    post :authenticate, { :login => {:email => 'real@user.com', :password => 'password'} }
    assert_redirected_to :controller => 'projects'
  end

end
