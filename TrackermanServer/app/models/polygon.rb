# == Schema Information
#
# Table name: polygons
#
#  id          :integer          not null, primary key
#  zone_id     :integer
#  json_points :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Polygon < ActiveRecord::Base
	belongs_to :zone
end
