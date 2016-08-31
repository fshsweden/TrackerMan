class Zone < ActiveRecord::Base
	has_many :polygons
	accepts_nested_attributes_for :polygons, :allow_destroy => true
end
