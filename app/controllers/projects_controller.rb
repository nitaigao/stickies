class ProjectsController < ApplicationController
  layout 'main'
  
  # GET /projects
  # GET /projects.xml
  def index
    user = User.find(session[:id])
    @projects = user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    return if !auth_check(@project)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end
  
  def auth_check(project)
    user = User.find(session[:id])
    if !user.projects.include?(project) then
      redirect_to :action => :index
      return false
    end
    return true
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end
  
  # GET /projects/1/adduser
  def adduser
    @project = Project.find(params[:id])
    return if !auth_check(@project)
    
    @email = params[:email]
    user = User.find(:first, :conditions => "email = '#{@email}'")
    
    if !user or user.id == @user.id then
      render :text => 'error', :layout => false
    else
      user.projects.push(@project)
      user.save
      render :layout => false
    end    
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    user = User.find(session[:id])
    user.projects.push(@project)
    
    respond_to do |format|
      if user.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    return if !auth_check(@project)

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    return if !auth_check(@project)
    
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
