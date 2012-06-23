class CreateMarketsTable < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft,   :null => false
      t.integer :rgt,   :null => false
      t.integer :depth, :null => false, :default => 0
    end
    add_index :markets, :parent_id

    add_column :users, :market_id, :integer
    add_index  :users, :market_id

    add_column :products, :market_id, :integer
    add_index  :products, :market_id
  end
end