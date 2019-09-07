json.extract! forecast, :id, :game_id, :pool_id, :selection, :created_at, :updated_at
json.url forecast_url(forecast, format: :json)
