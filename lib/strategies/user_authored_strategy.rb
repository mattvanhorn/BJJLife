class UserAuthoredStrategy < DecentExposure::ActiveRecordWithEagerAttributesStrategy
  delegate :current_user, :to => :controller

  def resource
    instance = super

    unless plural?
      if instance.new_record?
        instance.user ||= current_user
      end
    end
    instance
  end

end
