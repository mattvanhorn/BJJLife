class Identity < OmniAuth::Identity::Models::ActiveRecord
  attr_accessible  :email, :password, :password_confirmation
  belongs_to :user

  def self.find_by_uid(uid)
    find_by_id(uid)
  end

end