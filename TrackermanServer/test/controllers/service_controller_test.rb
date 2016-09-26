require 'test_helper'

class ServiceControllerTest < ActionController::TestCase

	include Devise::Test::ControllerHelpers

	setup do
		@request.env["devise.mapping"] = Devise.mappings[:admin]
		sign_in users(:fshsweden)
	end



end
