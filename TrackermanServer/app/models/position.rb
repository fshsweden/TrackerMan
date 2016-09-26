# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  lat        :string
#  lng        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Position < ActiveRecord::Base
	belongs_to :players
end
