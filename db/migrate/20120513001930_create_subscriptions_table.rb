class CreateSubscriptionsTable < ActiveRecord::Migration
  def change
    create_table :subscriptions, :force => true do |t|
      t.string :email
      t.timestamps
    end
    add_index :subscriptions, :email, :unique => true
  end
end