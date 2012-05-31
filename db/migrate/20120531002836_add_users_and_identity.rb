class AddUsersAndIdentity < ActiveRecord::Migration
  def change
    create_table :users, :force => true do |t|
      t.string :username, :limit => 32
      t.timestamps
    end

    create_table :identities, :force => true do |t|
      t.belongs_to :user
      t.string :email
      t.string :password_digest
      t.timestamps
    end
  end
end