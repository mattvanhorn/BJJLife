Fabricator(:identity) do
  email 'alice@example.com'
  password 'password'
  password_confirmation { |attrs| "#{attrs[:password]}" }
end