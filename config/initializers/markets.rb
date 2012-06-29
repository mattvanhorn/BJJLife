Rails.application.config.to_prepare do
  Market.create_constants if Market.table_exists? && Market.any?
end