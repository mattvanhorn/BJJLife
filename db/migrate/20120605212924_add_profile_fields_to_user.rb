class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :teacher,  :string
    add_column :users, :rank,     :string
  end
end