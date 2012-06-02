Fabricator(:identity) do
  email { 'alice@example.com' }
  password { 'password' }
  password_confirmation { |identity| "#{identity.password}" }
end