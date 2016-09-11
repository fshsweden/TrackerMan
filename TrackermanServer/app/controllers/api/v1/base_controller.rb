#
# NOTE that we derive from ActionController::Base and not ApplicationController, which has a lot of HTML stuff included!
#
#
class Api::V1::BaseController < ActionController::Base

	include ActiveHashRelation

	protect_from_forgery with: :null_session

	rescue_from ActiveRecord::RecordNotFound, with: :not_found

	before_action :destroy_session

	attr_accessor :current_user

	protected

	def authenticate_user!
		token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

		user_email = options.blank?? nil : options[:email]
		user = user_email && User.find_by(email: user_email)

		if user && ActiveSupport::SecurityUtils.secure_compare(user.token, token)
			@current_user = user
		else
			return unauthenticated!
		end
	end

	def not_found
		return api_error(status: 404, errors: 'Not found')
	end

	def destroy_session
		request.session_options[:skip] = true
	end

	def unauthenticated!
		response.headers['WWW-Authenticate'] = "Token realm=Application"
		render json: { error: 'Bad credentials' }, status: 401
	end

	def unauthorized!
		render json: { error: 'not authorized' }, status: 403
	end

	def invalid_resource!(errors = [])
		api_error(status: 422, errors: errors)
	end

	def not_found!
		return api_error(status: 404, errors: 'Not found')
	end

	def api_error(status: 500, errors: [])
		unless Rails.env.production?
			puts errors.full_messages if errors.respond_to? :full_messages
		end
		head status: status and return if errors.empty?

		render json: jsonapi_format(errors).to_json, status: status
	end

end
