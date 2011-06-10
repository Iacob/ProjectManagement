require 'web_auth'

class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @userTeams = @user.team

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
    @userTeams = @user.team
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
end
