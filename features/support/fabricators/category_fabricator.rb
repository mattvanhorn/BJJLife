Fabricator(:category) do
  name { sequence(:category_name) { |i| "category#{i}" } }
end