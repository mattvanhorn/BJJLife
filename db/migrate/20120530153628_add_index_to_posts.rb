class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :blog_id
  end
end
