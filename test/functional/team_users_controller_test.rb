require 'test_helper'

class TeamUsersControllerTest < ActionController::TestCase
  setup do
    @team_user = team_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_user" do
    assert_difference('TeamUser.count') do
      post :create, :team_user => @team_user.attributes
    end

    assert_redirected_to team_user_path(assigns(:team_user))
  end

  test "should show team_user" do
    get :show, :id => @team_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @team_user.to_param
    assert_response :success
  end

  test "should update team_user" do
    put :update, :id => @team_user.to_param, :team_user => @team_user.attributes
    assert_redirected_to team_user_path(assigns(:team_user))
  end

  test "should destroy team_user" do
    assert_difference('TeamUser.count', -1) do
      delete :destroy, :id => @team_user.to_param
    end

    assert_redirected_to team_users_path
  end
end
