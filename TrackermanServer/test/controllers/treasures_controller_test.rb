require 'test_helper'

class TreasuresControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers

  setup do
    @treasure = treasures(:one)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    #sign_in FactoryGirl.create(:admin)
    sign_in users(:fshsweden)

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:treasures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create treasure" do
    assert_difference('Treasure.count') do
      post :create, treasure: { lat: @treasure.lat, lng: @treasure.lng, name: @treasure.name, num_takers: @treasure.num_takers, start: @treasure.start, stop: @treasure.stop, value: @treasure.value }
    end

    assert_redirected_to treasure_path(assigns(:treasure))
  end

  test "should show treasure" do
    get :show, id: @treasure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @treasure
    assert_response :success
  end

  test "should update treasure" do
    patch :update, id: @treasure, treasure: { lat: @treasure.lat, lng: @treasure.lng, name: @treasure.name, num_takers: @treasure.num_takers, start: @treasure.start, stop: @treasure.stop, value: @treasure.value }
    assert_redirected_to treasure_path(assigns(:treasure))
  end

  test "should destroy treasure" do
    assert_difference('Treasure.count', -1) do
      puts "calling destroy"
      delete :destroy, id: @treasure
      puts "called destroy"
    end

    puts "destroy - redirect"

    assert_redirected_to treasures_path
  end
end
