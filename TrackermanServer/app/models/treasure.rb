# == Schema Information
#
# Table name: treasures
#
#  id         :integer          not null, primary key
#  name       :string
#  lat        :decimal(, )
#  lng        :decimal(, )
#  value      :integer
#  start      :datetime
#  stop       :datetime
#  num_takers :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Treasure < ActiveRecord::Base
end
