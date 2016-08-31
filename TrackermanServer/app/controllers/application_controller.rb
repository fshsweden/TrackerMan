 class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    before_action :set_menu
    before_action :authenticate_html_only
    before_action :check_area

  #protect_from_forgery with: :exception

	protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }

	private

    def check_area
		if !@current_area
			redirect_to :controller => :area_controller, :action => :select
		end
    end

    def authenticate_html_only

		#
		#  for html : authenticate_user!
		#  for json : nothing!
		#
		#

    end

	def set_menu

		@current_area = 1
		@current_zone = 1

		# dynamic menu here!
		@menuitems = {
			'Areas' => areas_path,
			'Zones' => area_zones_path(@current_area),
			'Places' => area_zone_places_path(@current_area, @current_zone),
			'Treasures' => treasures_path,
			'Players' => players_path
		}

		@menuitems.each do |key, val|
			puts "KEY=" + key.to_s
			puts "VAL=" + val.to_s
		end


	end
end
