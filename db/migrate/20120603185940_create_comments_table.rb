class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments, :force => true do |t|
      t.belongs_to :post
      t.belongs_to :user
      t.text :body
      t.timestamps
    end
    add_index :comments, :post_id
    add_index :comments, :user_id
  end
end