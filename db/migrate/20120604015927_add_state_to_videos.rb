class AddStateToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :state, :string, :default => 'pending'
  end
end
