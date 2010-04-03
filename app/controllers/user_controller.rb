class UserController < ApplicationController
  layout 'guest'
  skip_before_filter :authenticate
  
  def logout
    session[:id] = nil
    redirect_to :controller => 'welcome'
  end
  
  def create    
    if (params['registration']['password'] != params['registration']['password_confirmed']) then
      flash[:notice] = 'Your passwords dont match'
      render :action => "signup" 
      return
    end

    if User.find(:first, :conditions => { :email => params['registration']['email'], :password => params['registration']['password'] }) then
      flash[:notice] = 'User already exists.'
      render :action => "signup"
      return
    end
    
    user = User.new do |signup|
      signup.email = params['registration']['email']
      signup.password = params['registration']['password']
    end 
    user.save
    session[:id] = user.id
    redirect_to :controller => "projects"    
  end
  
  def findall 
    users = User.find(:all)
  end
  
  def authenticate
    user = User.find(:first, :conditions => { :email => params['login']['email'], :password => params['login']['password'] })

    if user then
      session[:id] = user.id
      redirect_to :controller => 'projects'
      return  
    end

    flash[:notice] = 'Sorry buddy, those account details are wrong.'
    render :action => 'login'
  end
  
end
