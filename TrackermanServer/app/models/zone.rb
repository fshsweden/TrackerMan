# == Schema Information
#
# Table name: zones
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  area_id     :integer
#  json_points :text
#

class Zone < ActiveRecord::Base
	has_many :polygons
	accepts_nested_attributes_for :polygons
end
