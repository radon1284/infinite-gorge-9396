json.array!(@clients) do |client|
  json.extract! client, :id, :full_name, :postion
  json.url client_url(client, format: :json)
end
