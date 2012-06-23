Fabricator(:market, aliases: [:different_market]) do
  name { sequence(:market_name) { |i| "market#{i}" } }
end
