require 'test_helper'

class AreasControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers

  setup do
    @area = areas(:one)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    #sign_in FactoryGirl.create(:admin)
    sign_in users(:fshsweden)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area" do
    assert_difference('Area.count') do
      post :create, area: { name: @area.name }
    end

    assert_redirected_to area_path(assigns(:area))
  end

  test "should show area" do
    get :show, id: @area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @area
    assert_response :success
  end

  test "should update area" do
    patch :update, id: @area, area: { name: @area.name }
    assert_redirected_to area_path(assigns(:area))
  end

  test "should destroy area" do

    puts "TEST area controller destroy start"

    assert_difference('Area.count', -1) do
      delete :destroy, id: @area
    end
    puts "TEST area controller destroy middle"

    assert_redirected_to areas_path
    puts "TEST area controller destroy end"
  end
end
