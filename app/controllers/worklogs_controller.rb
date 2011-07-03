require 'web_auth'

class WorklogsController < ApplicationController
  # Authentication
  include ModuleDbAuthenticate
  before_filter :authenticate

  # GET /worklogs
  # GET /worklogs.xml
  def index
    # Find login user.
    @user = User.find_by_login(@current_login)

    @worklogs = Report.paginate :page => params[:page], :conditions => ["user_id = ?", @user.id], :order => 'date ASC', :per_page => 20

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @worklogs }
    end
  end

  # GET /worklogs/1
  # GET /worklogs/1.xml
  def show
    # Authentication
    include ModuleDbAuthenticate
    before_filter :authenticate

    # Find login user.
    @user = User.find_by_login(@current_login)

    @worklog = Report.find_by_id_and_user_id(params[:id], @user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @worklog }
    end
  end

  # GET /worklogs/new
  # GET /worklogs/new.xml
  def new
    # Find login user.
    @user = User.find_by_login(@current_login)

    @user_tasks = get_user_tasks(@user.id)
    @user_workitems = get_user_workitems(@user.id)

    @worklog = Report.new
    @worklog.user_id = @user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @worklog }
    end
  end

  # GET /worklogs/1/edit
  def edit
    # Find login user.
    @user = User.find_by_login(@current_login)

    @user_tasks = get_user_tasks(@user.id)
    @user_workitems = get_user_workitems(@user.id)
    puts @user_tasks.inspect
    puts @user_workitems.inspect

    @worklog =Report.find_by_id_and_user_id(params[:id], @user.id)
  end

  # POST /worklogs
  # POST /worklogs.xml
  def create
    # Find login user.
    @user = User.find_by_login(@current_login)

    @worklog = Report.new(params[:worklog])
    @worklog.user_id = @user.id

    respond_to do |format|
      if @worklog.save
        format.html { redirect_to(@worklog, :notice => 'Report was successfully created.') }
        format.xml  { render :xml => @worklog, :status => :created, :location => @worklog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @worklog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /worklogs/1
  # PUT /worklogs/1.xml
  def update
    # Find login user.
    @user = User.find_by_login(@current_login)

    @worklog = Report.find_by_id_and_user_id(params[:id], @user.id)
    @worklog.user_id = @user.id

    respond_to do |format|
      if @worklog.update_attributes(params[:worklog])
        format.html { redirect_to(@worklog, :notice => 'Report was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @worklog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /worklogs/1
  # DELETE /worklogs/1.xml
  def destroy
    # Find login user.
    @user = User.find_by_login(@current_login)

    @worklog = Report.find_by_id_and_user_id(params[:id], @user.id)
    @worklog.destroy

    respond_to do |format|
      format.html { redirect_to(worklogs_url) }
      format.xml  { head :ok }
    end
  end

private

  def get_user_tasks(user_id)
    Project.where("exists (select team_user.user_id from team_task, team_user where team_task.task_id = task.id and team_task.team_id = team_user.team_id and team_user.user_id = ?)", user_id).all
  end

  def get_user_workitems(user_id)
    Workitem.where("exists (select team_user.user_id from task_workitem, team_task, team_user where task_workitem.workitem_id = workitem.id and task_workitem.task_id = team_task.task_id and team_task.team_id = team_user.team_id and team_user.user_id = ?)", user_id).all
  end

end
