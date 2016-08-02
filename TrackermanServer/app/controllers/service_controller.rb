class ServiceController < ApplicationController
	
	# GET
	def get_users
		@players = Player.all
		render json: @players
	end

	# POST
	def create_player
		if (Player.create(player_params))
			render json: "OK"		
		else
			render json: "FAIL"
		end
	end

	private

	def player_params
		params.require(:player).permit(:name, :lat, :lng)
	end
end
