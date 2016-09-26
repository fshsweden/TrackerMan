require 'test_helper'

class ZonesControllerTest < ActionController::TestCase

  include Devise::Test::ControllerHelpers

  setup do
    @zone1 = zones(:one)
    @zone2 = zones(:one)

    @request.env["devise.mapping"] = Devise.mappings[:admin]
    #sign_in FactoryGirl.create(:admin)
    sign_in users(:fshsweden)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zone" do

    puts "1"

    assert_difference('Zone.count') do
      puts "2"
      post :create, zone: { name: @zone1.name }
      puts "33333"
    end

    puts "3"
    assert_redirected_to zone_path(assigns(:zone))
  end

end
