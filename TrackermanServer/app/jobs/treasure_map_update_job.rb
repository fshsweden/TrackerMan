class TreasureMapUpdateJob < ActiveJob::Base
  queue_as :default

  def perform(*args)

	  # Check all treasures

	  @treasures = Treasure.all
	  @treasures.each do |t|

		  if t.expired
			  # t.destroy
		  else

		  end

	  end

  end
end
