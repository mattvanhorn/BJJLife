class ContributorExhibit< BaseExhibit

  def self.applicable_to?(object)
    ['Comment', 'Post'].include? object.class.name
  end

  def contributor
    user.try(:username) || 'anonymous'
  end

end