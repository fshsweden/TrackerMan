class Player < ActiveRecord::Base

	#include ActiveModel::Serialization

	has_many :positions
end
