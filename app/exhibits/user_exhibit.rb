class UserExhibit < BaseExhibit

  def self.applicable_to?(object)
    object.class.name == 'User'
  end

  def greeting
    name = username.presence || 'there'
    "Hi #{name},"
  end

  def email
    identity.email
  end

end