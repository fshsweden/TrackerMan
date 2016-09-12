class Api::V1::SessionsController < Api::V1::BaseController

	def create

		user = User.find_by(email: create_params[:email])
		puts "LOGIN #{user.password} PARAM: #{create_params[:email]} "

		if user # && user.password == create_params[:password]
			self.current_user = user
			render(
				json: Api::V1::SessionSerializer.new(user, root: false).to_json,
				status: 201
			)
		else
			return api_error(status: 401)
		end
	end

	private

	def create_params
		params.require(:user).permit(:email, :password)
	end

	def authenticate

	end
end

