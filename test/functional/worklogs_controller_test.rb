require 'test_helper'

class WorklogsControllerTest < ActionController::TestCase
  setup do
    @worklog = worklogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:worklogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create worklog" do
    assert_difference('Worklog.count') do
      post :create, :worklog => @worklog.attributes
    end

    assert_redirected_to worklog_path(assigns(:worklog))
  end

  test "should show worklog" do
    get :show, :id => @worklog.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @worklog.to_param
    assert_response :success
  end

  test "should update worklog" do
    put :update, :id => @worklog.to_param, :worklog => @worklog.attributes
    assert_redirected_to worklog_path(assigns(:worklog))
  end

  test "should destroy worklog" do
    assert_difference('Worklog.count', -1) do
      delete :destroy, :id => @worklog.to_param
    end

    assert_redirected_to worklogs_path
  end
end
