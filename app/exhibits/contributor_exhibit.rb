class ContributorExhibit< DisplayCase::Exhibit

  def self.applicable_to?(object)
    ['Comment', 'Post'].include? object.class.name
  end

  def contributor
    __getobj__.user.try(:username) || 'anonymous'
  end

end