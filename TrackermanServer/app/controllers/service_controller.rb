class ServiceController < ApplicationController
	
	def register
		
	end

	# GET
	def get_users
		@players = Player.all
		render json: @players
	end

	# GET
	def get_users_position_list
		@player = Player.find(param[:id])
		render json: @player.positions
	end


	# POST
	def create_player
		if Player.create(params)
			render json: "OK"		
		else
			render json: "FAIL"
		end

		# use this!
		# render :json => { :errors => @contacts.errors.as_json }, :status => 420
	end



	#
	#  PING from a player!
	#

	def ping_android
		puts "PING from Android!"
	end

	def ping
		add_pos
	end

	# POST add position to player
	# arguments:

	def add_pos

		@name = params['player']['info']['name']

		params.each do |key, array|
				
 			if key == "player"
				@player = Player.where("name = ?", @name).first
				if @player == nil
					puts "Player #{@name} NOT found in database"
					
					@player = Player.new
					@player.name = @name
					@player.save
				else
					puts "Player #{@name} found in database"
				end
  			end

 			if key == "positions" 
 				puts "THIS KEY: " + params[key].inspect
 				puts "KEY: " + key
 				puts "KEY COUNT: " + params[key].count.to_s

 				params[key].each do |key, value|

 					puts "TS=" + key
 					
					@latitude = value['lat']
					@longitude = value['lng']

  					puts "#{key} a location entry with user #{@name} LAT=#{@latitude} and LONG=#{@longitude}"

					@player.positions.build(:lat => @latitude, :lng => @longitude)
				end

				@player.save

 			end

		end

		render json: "OK", :status => 200
		Pusher.trigger('test_channel', 'my_event', {
			                             message: 'position added!'
		                             })
	end


	#
	#
	#
	def get_treasures_within

		# todo add check!
		diameter = params[:distance]
		lat = params[:lat]
		lng = params[:lng]
		@treasures = find_treasures_within(lat,lng,@diameter)
	end

	private

	def find_treasures_within(lat,lng,dist)
		result = []
		treasures = Treasure.all
		treasure.each do |t|
			if distance(lat,lng,t.lat,t.lng) >= dist
				result.push(t)
			end
		end
		result
	end

	def player_params
		@filtered = params.permit(:name, :age)
		puts "Filtered Player params: #{@filtered}" 
		@filtered
	end

	def player_params_2
		params.require(:player).permit(:name, :lat, :lng)
	end

	def position_params
		params.require(:position).permit(:player_id, :lat, :lng)
	end

end
