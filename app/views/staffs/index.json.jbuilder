json.array!(@staffs) do |staff|
  json.extract! staff, :id, :full_name, :postion
  json.url staff_url(staff, format: :json)
end
