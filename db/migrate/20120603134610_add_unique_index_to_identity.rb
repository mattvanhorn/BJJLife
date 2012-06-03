class AddUniqueIndexToIdentity < ActiveRecord::Migration
  def change
    add_index :identities, :email, :unique => true
  end
end
