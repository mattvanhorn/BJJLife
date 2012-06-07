class CreateProductsTable < ActiveRecord::Migration
  def change
    create_table :products, :force => true do |t|
      t.string :name
      t.integer :price
      t.string :photo
      t.timestamps
    end
  end
end