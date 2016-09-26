require 'test_helper'

class PlacesControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers

  setup do
    @place = places(:one)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    #sign_in FactoryGirl.create(:admin)
    sign_in users(:fshsweden)

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post :create, place: { lat: @place.lat, lng: @place.lng, name: @place.name, value: @place.value }
    end

    assert_redirected_to place_path(assigns(:place))
  end

  test "should show place" do
    get :show, id: @place
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @place
    assert_response :success
  end

  test "should update place" do
    patch :update, id: @place, place: { lat: @place.lat, lng: @place.lng, name: @place.name, value: @place.value }
    assert_redirected_to place_path(assigns(:place))
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete :destroy, id: @place
    end

    assert_redirected_to places_path
  end
end
