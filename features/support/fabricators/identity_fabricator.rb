Fabricator(:identity) do
  email 'alice@example.com'
  password 'password'
  password_confirmation { |attrs| "#{attrs[:password]}" }
end

Fabricator(:identity_with_user, from: :identity) do
  transient :username
  transient :sign_in_count
  user { |attrs|
    Fabricate(:user_with_profile, sign_in_count: attrs[:sign_in_count]||0,
                                  username: attrs[:username]) }
end

Fabricator(:identity_with_user_in_market, from: :identity) do
  transient :username
  transient :market
  transient :sign_in_count
  user { |attrs|
    Fabricate(:user_with_profile, sign_in_count: attrs[:sign_in_count]||0,
                                  username:      attrs[:username],
                                  market:        attrs[:market]) }
end
