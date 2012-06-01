class AddSignInStatsToUser < ActiveRecord::Migration
  def change
    add_column :users, :sign_in_count, :integer, :null => false, :default => 0
  end
end