class Api::V1::PlayerSerializer < Api::V1::BaseSerializer

	attributes :id, :name,  :lat, :lng, :created_at, :updated_at, :login_time

	#has_many :microposts
	#has_many :following
	#has_many :followers

	def created_at
		object.created_at.in_time_zone.iso8601 if object.created_at
	end

	def updated_at
		object.updated_at.in_time_zone.iso8601 if object.created_at
	end
end

