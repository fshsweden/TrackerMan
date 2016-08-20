json.extract! treasure, :id, :name, :lat, :lng, :value, :start, :stop, :num_takers, :created_at, :updated_at
json.url treasure_url(treasure, format: :json)