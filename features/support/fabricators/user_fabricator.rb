Fabricator(:user) do
  username 'alice'
  location
end

Fabricator(:user_with_profile, class_name: :user) do
  username "Alice K"
  location
  teacher "Vitor 'Shaolin' Ribeiro"
  rank "Blue belt"
  sign_in_count 2
end
