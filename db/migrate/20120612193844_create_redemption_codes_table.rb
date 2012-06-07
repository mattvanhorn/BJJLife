class CreateRedemptionCodesTable < ActiveRecord::Migration
  def change
    create_table :redemption_codes, :force => true do |t|
      t.integer :order_item_id, :null => false
      t.string  :token,         :null => false, :unique => true
      t.timestamps
    end
  end
end