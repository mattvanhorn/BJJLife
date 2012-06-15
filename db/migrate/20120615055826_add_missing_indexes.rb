class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :order_adjustments, :order_id
    add_index :order_items, :order_id
    add_index :order_items, :product_id
    add_index :order_transactions, :order_id
    add_index :orders, :user_id
    add_index :redemption_codes, :order_item_id
  end
end
