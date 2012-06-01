class TieSubscriptionsTouser < ActiveRecord::Migration
  def up
    add_column :subscriptions, :user_id, :integer
    add_index  :subscriptions, :user_id
    execute "UPDATE subscriptions SET user_id = identities.user_id FROM identities WHERE subscriptions.email = identities.email"
  end

  def down
    remove_index  :subscriptions, :user_id
    remove_column :subscriptions, :user_id
  end
end