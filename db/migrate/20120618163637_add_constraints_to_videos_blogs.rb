class AddConstraintsToVideosBlogs < ActiveRecord::Migration
  def change
    change_column :videos, :name,  :string, :null => false
    change_column :videos, :url,   :string, :null => false
    change_column :blogs,  :title, :string, :null => false
  end
end