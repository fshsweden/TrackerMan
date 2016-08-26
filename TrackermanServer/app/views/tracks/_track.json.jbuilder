json.extract! track, :id, :name, :track_type, :difficulty, :length, :created_at, :updated_at
json.url track_url(track, format: :json)