class Area < ActiveRecord::Base
	has_many :zones
	accepts_nested_attributes_for :zones, :allow_destroy => true
end
