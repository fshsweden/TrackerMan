# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string
#  lat        :string
#  lng        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  login_time :datetime
#

class Player < ActiveRecord::Base

	#include ActiveModel::Serialization

	has_many :positions
end
