class TeamUsersController < ApplicationController
  # GET /team_users
  # GET /team_users.xml
  def index
    @team_users = TeamUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_users }
    end
  end

  # GET /team_users/1
  # GET /team_users/1.xml
  def show
    @team_user = TeamUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_user }
    end
  end

  # GET /team_users/new
  # GET /team_users/new.xml
  def new
    @team_user = TeamUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_user }
    end
  end

  # GET /team_users/1/edit
  def edit
    @team_user = TeamUser.find(params[:id])
  end

  # POST /team_users
  # POST /team_users.xml
  def create
    @team_user = TeamUser.new(params[:team_user])

    respond_to do |format|
      if @team_user.save
        format.html { redirect_to(@team_user, :notice => 'Team user was successfully created.') }
        format.xml  { render :xml => @team_user, :status => :created, :location => @team_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_users/1
  # PUT /team_users/1.xml
  def update
    @team_user = TeamUser.find(params[:id])

    respond_to do |format|
      if @team_user.update_attributes(params[:team_user])
        format.html { redirect_to(@team_user, :notice => 'Team user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_users/1
  # DELETE /team_users/1.xml
  def destroy
    @team_user = TeamUser.find(params[:id])
    @team_user.destroy

    respond_to do |format|
      format.html { redirect_to(team_users_url) }
      format.xml  { head :ok }
    end
  end
end
