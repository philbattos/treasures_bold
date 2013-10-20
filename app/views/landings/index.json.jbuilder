json.array!(@landings) do |landing|
  json.extract! landing, :feature_id, :feature_name, :feature_class
  json.url landing_url(landing, format: :json)
end
