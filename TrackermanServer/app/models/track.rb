class Track < ActiveRecord::Base
	has_many :controls, :dependent => :destroy

	accepts_nested_attributes_for :controls, :allow_destroy => true,:reject_if => :all_blank
end
