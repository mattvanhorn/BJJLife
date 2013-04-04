class UserExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
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
