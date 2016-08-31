class XareaController < ApplicationController
	def select
		@current_area = params[:area]
	end
end

