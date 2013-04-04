class ContributorExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    ['Comment', 'Post'].include? object.class.name
  end

  def contributor
    user.try(:username) || 'anonymous'
  end

end