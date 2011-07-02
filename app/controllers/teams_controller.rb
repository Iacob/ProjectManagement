require 'web_auth'
require 'common_utils'

class TeamsController < ApplicationController

  # Authentication
  include ModuleDbAuthenticateAdmin
  before_filter :authenticate

  # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])
    @teamUsers = @team.users
    @teamProjects = @team.projects

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new
    @userAll = User.all
    @allProjects = Project.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    # User
    @userAll = User.all
    @teamUsers = @team.users
    # Project
    @allProjects = Project.all
    @teamProjects = @team.projects
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])

    _team_users = params[:selected_team_users]

    @team.user_ids = (_team_users.nil?)?nil:_team_users.map {|id_str| id_str.to_i}

    _team_projects = params[:selected_team_projects]

    @team.project_ids = (_team_projects.nil?)?nil:_team_projects.map {|id_str| id_str.to_i}

    respond_to do |format|
      if @team.save
        format.html { redirect_to(@team, :notice => 'Team was successfully created.') }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @team = Team.find(params[:id])

    _team_users = params[:selected_team_users]

    @team.user_ids = (_team_users.nil?)?nil:_team_users.map {|id_str| id_str.to_i}

    _team_projects = params[:selected_team_projects]

    @team.project_ids = (_team_projects.nil?)?nil:_team_projects.map {|id_str| id_str.to_i}
    
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to(@team, :notice => 'Team was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end

  # GET /teams/1/statistics
  # GET /teams/1/statistics.xml
  def statistics

    @team = Team.find(params[:id])
    @start_date
    @end_date
    @teams
    @report_weeks = {}

    _stat_date = params[:stat_date]
    unless _stat_date.nil?
      @start_date = Date.new(_stat_date["start(1i)"].to_i, _stat_date["start(2i)"].to_i, _stat_date["start(3i)"].to_i)
      @end_date = Date.new(_stat_date["end(1i)"].to_i, _stat_date["end(2i)"].to_i, _stat_date["end(3i)"].to_i)

      # Split date period to weeks.
      _weeks = split_weeks(@start_date, @end_date)
      _weeks.each do |period_start|
        # End of the week.
        _period_end = period_start.next_week.yesterday
        if _period_end > @end_date
          _query = get_report_query(@team.id, period_start, @end_date)
          @report_weeks[period_start] = _query.all
          break
        else
          _query = get_report_query(@team.id, period_start, _period_end)
          @report_weeks[period_start] = _query.all
        end
      end
      puts @report_weeks.inspect

    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end


private

  def get_report_query(team_id, start_date, end_date)
    Report.select("sum(hours) as hours, task.name as task_name, workitem.name as workitem_name") \
      .from("report, user, task, workitem") \
      .where("report.date" => start_date..end_date) \
      .where("report.user_id = user.id") \
      .where("report.task_id = task.id") \
      .where("report.workitem_id = workitem.id") \
      .where("exists(select team_id from team_user where user_id=user.id and team_id=?)", team_id) \
      .group("task_id, workitem_id, task_name, workitem_name") \
      .order("task_id, workitem_id")
  end
end
