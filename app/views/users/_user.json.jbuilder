json.extract! user, :id, :name, :about, :birthdate, :hometown, :present_location, :role, :status, :created_at, :updated_at
json.url user_url(user, format: :json)
