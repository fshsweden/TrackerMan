 class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_menu
  #before_action :authenticate_html_only, :only => [:create]
  before_action :authenticate_html_only_simple, :only => [:create]

  #protect_from_forgery with: :exception

	protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }

	private

    def authenticate_html_only

		#
		#  for html : authenticate_user!
		#  for json : nothing!
		#
		#
		h = request.env()

		puts "authenticate_html_only, here are all the ENV variables"
	    h.each do |key, val|
		    puts ">>> " + key.to_s + " = " + val.to_s
	    end
		puts "authenticate_html_only, DONE"

		#
		# Client asks for javascript  (should be json!!)
		#
		if h["HTTP_ACCEPT"] != nil && h["HTTP_ACCEPT"] == "application/json"
			puts ">>>>>>>>>>> " + h["HTTP_ACCEPT"]
			# NO AUTH!
			# TODO: Add separate authentication later...
			# verify that h["token"] == current_user.token
		else
			authenticate_user!
		end
    end

    def authenticate_html_only_simple
	    authenticate_user!
    end

	def set_menu

		@current_area = 1
		@current_zone = 1

		# dynamic menu here!
		@menuitems = {
			'Players' => players_path,
			'Zones' => zones_path,
			'Places' => places_path,
			'Treasures' => treasures_path
			#'Players' => players_path
		}

	end
end
