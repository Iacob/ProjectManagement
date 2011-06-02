require 'test_helper'

class UserTeamsControllerTest < ActionController::TestCase
  setup do
    @user_team = user_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_team" do
    assert_difference('UserTeam.count') do
      post :create, :user_team => @user_team.attributes
    end

    assert_redirected_to user_team_path(assigns(:user_team))
  end

  test "should show user_team" do
    get :show, :id => @user_team.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_team.to_param
    assert_response :success
  end

  test "should update user_team" do
    put :update, :id => @user_team.to_param, :user_team => @user_team.attributes
    assert_redirected_to user_team_path(assigns(:user_team))
  end

  test "should destroy user_team" do
    assert_difference('UserTeam.count', -1) do
      delete :destroy, :id => @user_team.to_param
    end

    assert_redirected_to user_teams_path
  end
end
