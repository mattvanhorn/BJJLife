class AddStateToAcademy < ActiveRecord::Migration
  def change
    add_column :academies, :state, :string, :default => 'pending'
  end
end
