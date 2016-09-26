
class PlayersController < ApplicationController
	
	def index
		@recent_players = Player.where("login_time > ?", 1.hour.ago)
		@players = Player.where("login_time <= ?", 1.hour.ago)
	end

	def show
		@player = Player.find(params[:id])
	end

end

