json.array!(@searches) do |search|
  json.extract! search, :verbatim, :terms
  json.url search_url(search, format: :json)
end
