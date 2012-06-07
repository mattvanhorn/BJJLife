class CreateOrdersTable < ActiveRecord::Migration
  def change
    create_table :orders, :force => true do |t|
      t.belongs_to :user
      t.string :state
      t.string :bill_first_name,  :limit => 32
      t.string :bill_last_name,   :limit => 32
      t.string :bill_street
      t.string :bill_unit
      t.string :bill_city
      t.string :bill_us_state,    :limit => 2
      t.string :bill_postal_code, :limit => 10
      t.string :email
      t.string  :cc_type
      t.integer :cc_exp_month
      t.integer :cc_exp_year
      t.string  :cc_last4,        :limit => 4
      t.string  :cc_fingerprint
      t.string  :cc_country
      t.string :currency,         :limit => 3,  :null => false, :default => 'usd'
      t.integer :amount,                        :null => false
      t.timestamps
    end

    create_table :order_items, :force => true do |t|
      t.integer :order_id,    :null => false
      t.integer :product_id,  :null => false
      t.integer :quantity,    :null => false, :default => 1
      t.integer :unit_price,  :null => false
      t.integer :adjustment,  :null => false, :default => 0
      t.integer :price,       :null => false
      t.timestamps
    end

    create_table :order_transactions, :force => true do |t|
      t.belongs_to :order
      t.string :charge_id
      t.timestamps
    end

    create_table :order_adjustments, :force => true do |t|
      t.belongs_to :order
      t.integer :amount
      t.timestamps
    end
  end
end
