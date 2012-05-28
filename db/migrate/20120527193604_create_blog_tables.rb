class CreateBlogTables < ActiveRecord::Migration
  def change
    create_table :blogs, :force => true do |t|
      t.string :title
      t.timestamps
    end
    create_table :posts, :force => true do |t|
      t.belongs_to :blog
      t.string :title
      t.string :url
      t.text :description
      t.timestamps
    end
  end
end