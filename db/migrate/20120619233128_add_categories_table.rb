class AddCategoriesTable < ActiveRecord::Migration
  def change
    create_table :categories, :force => true do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :categories, :name, :unique => true

    add_column :products, :description, :text
    add_column :products, :category_id, :integer
    add_index :products, :category_id
  end
end