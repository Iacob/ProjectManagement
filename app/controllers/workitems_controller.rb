require 'web_auth'

class WorkitemsController < ApplicationController

  # Authentication
  include ModuleDbAuthenticateAdmin
  before_filter :authenticate

  # GET /workitems
  # GET /workitems.xml
  def index
    @workitems = Workitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workitems }
    end
  end

  # GET /workitems/1
  # GET /workitems/1.xml
  def show
    @workitem = Workitem.find(params[:id])
    @workitemProjects = @workitem.projects

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workitem }
    end
  end

  # GET /workitems/new
  # GET /workitems/new.xml
  def new
    @workitem = Workitem.new
    @allProjects = Project.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workitem }
    end
  end

  # GET /workitems/1/edit
  def edit
    @workitem = Workitem.find(params[:id])
    @allProjects = Project.all
    @workitemProjects = @workitem.projects
  end

  # POST /workitems
  # POST /workitems.xml
  def create
    @workitem = Workitem.new(params[:workitem])
    
    _workitem_projects = params[:selected_workitem_projects]
    puts "The information is:"
    puts _workitem_projects.inspect
    _project_ids = _workitem_projects.map {|id_str| id_str.to_i}
    puts _project_ids.inspect

    @workitem.project_ids = (_workitem_projects.nil?)?nil:_workitem_projects.map {|id_str| id_str.to_i}

    respond_to do |format|
      if @workitem.save
        format.html { redirect_to(@workitem, :notice => 'Workitem was successfully created.') }
        format.xml  { render :xml => @workitem, :status => :created, :location => @workitem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workitems/1
  # PUT /workitems/1.xml
  def update
    @workitem = Workitem.find(params[:id])

    _workitem_projects = params[:selected_workitem_projects]

    @workitem.project_ids = (_workitem_projects.nil?)?nil:_workitem_projects.map {|id_str| id_str.to_i}

    respond_to do |format|
      if @workitem.update_attributes(params[:workitem])
        format.html { redirect_to(@workitem, :notice => 'Workitem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workitems/1
  # DELETE /workitems/1.xml
  def destroy
    @workitem = Workitem.find(params[:id])
    @workitem.destroy

    respond_to do |format|
      format.html { redirect_to(workitems_url) }
      format.xml  { head :ok }
    end
  end
end
