 class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    before_action :set_menu
    before_action :authenticate_html_only

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

    end

	def set_menu

		# dynamic menu here!
		@menuitems = {
			'Treasures' => treasures_path,
			'Players' => players_path
		}

		@menuitems.each do |key, val|
			puts "KEY=" + key.to_s
			puts "VAL=" + val.to_s
		end
	end
end
