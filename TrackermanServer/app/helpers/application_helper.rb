module ApplicationHelper

	def distance_between(lat1, lon1, lat2, lon2)
		rad_per_deg = Math::PI / 180
		rm = 6371000 # Earth radius in meters

		lat1_rad, lat2_rad = lat1 * rad_per_deg, lat2 * rad_per_deg
		lon1_rad, lon2_rad = lon1 * rad_per_deg, lon2 * rad_per_deg

		a = Math.sin((lat2_rad - lat1_rad) / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin((lon2_rad - lon1_rad) / 2) ** 2
		c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

		rm * c # Delta in meters
	end

end
