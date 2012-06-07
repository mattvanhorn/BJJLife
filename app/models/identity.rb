# == Schema Information
#
# Table name: identities
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#
# Indexes
#
#  index_identities_on_email    (email) UNIQUE
#  index_identities_on_user_id  (user_id)
#

class Identity < OmniAuth::Identity::Models::ActiveRecord
  attr_accessor :opt_in
  attr_accessible  :email, :password, :password_confirmation, :opt_in
  belongs_to :user

  validates_uniqueness_of :email

  after_create :process_opt_in

  def self.find_by_uid(uid)
    find_by_id(uid)
  end

  private

  def process_opt_in
    attach_user
    if opt_in
      Subscription.find_or_create_by_email(email) do |sub|
        sub.user = user
      end
    else
      Subscription.destroy_all(:email => email)
    end
  end

  def attach_user
    unless user
      build_user && save!
    end
  end
end
