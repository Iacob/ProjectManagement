require 'web_auth'
require 'common_utils'

class UsersController < ApplicationController

  # Authentication
  include ModuleDbAuthenticateAdmin
  before_filter :authenticate

  # GET /users
  # GET /users.xml
  def index
    # @users = User.all
    # @users = User.paginate :page => params[:page], :order => 'created_at DESC'
    @users = User.paginate :page => params[:page], :order => 'login ASC', :per_page => 20

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @userTeams = @user.teams

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @allTeams = Team.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @allTeams = Team.all
    @userTeams = @user.teams
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    # Encrypt password.
    _password = params[:user][:password]
    @user.crypted_password = encrypt_password(_password)

    _user_teams = params[:selected_user_teams]

    @user.team_ids = (_user_teams.nil?)?nil:_user_teams.map {|id_str| id_str.to_i}

    # Extract selected user roles information.
    _user_roles = params[:selected_user_roles]
    _user_roles_str = nil
    _user_roles_str = _user_roles.join(',') if (!_user_roles.nil?)
    @user.roles = _user_roles_str

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    _oldPassword = @user.crypted_password

    # Encrypt user password.
    _password = params[:user][:password]
    if ((_password.nil?) or (_password == ''))
      @user.crypted_password = _oldPassword
    else
      @user.crypted_password = encrypt_password(_password)
    end

    _user_teams = params[:selected_user_teams]
    @user.team_ids = (_user_teams.nil?)?nil:_user_teams.map {|id_str| id_str.to_i}

    # Extract selected user roles information.
    _user_roles = params[:selected_user_roles]
    _user_roles_str = nil
    _user_roles_str = _user_roles.join(',') if (!_user_roles.nil?)
    @user.roles = _user_roles_str

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # GET /users/1/statistics
  # GET /users/1/statistics.xml
  def statistics

    @user = User.find(params[:id])
    @start_date
    @end_date
    @users
    # @reports
    @report_weeks = {}

    _stat_date = params[:stat_date]
    unless _stat_date.nil?
      @start_date = Date.new(_stat_date["start(1i)"].to_i, _stat_date["start(2i)"].to_i, _stat_date["start(3i)"].to_i)
      @end_date = Date.new(_stat_date["end(1i)"].to_i, _stat_date["end(2i)"].to_i, _stat_date["end(3i)"].to_i)

      #_query = get_report_query(@user.id, @start_date, @end_date)
      #@reports = _query.all

      # Split date period to weeks.
      _weeks = split_weeks(@start_date, @end_date)
      _weeks.each do |period_start|
        # End of the week.
        _period_end = period_start.next_week.yesterday
        if _period_end > @end_date
          _query = get_report_query(@user.id, period_start, @end_date)
          @report_weeks[period_start] = _query.all
          break
        else
          _query = get_report_query(@user.id, period_start, _period_end)
          @report_weeks[period_start] = _query.all
        end
      end
      puts @report_weeks.inspect

    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end


private

  def get_report_query(user_id, start_date, end_date)
    Report.select("sum(hours) as hours, task.name as task_name, workitem.name as workitem_name") \
      .joins(:user, :project, :workitem) \
      .where("report.date" => start_date..end_date, "report.user_id" => user_id)\
      .group("task_id, workitem_id, task_name, workitem_name") \
      .order("task_id, workitem_id")
  end
end
