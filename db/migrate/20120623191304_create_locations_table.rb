class CreateLocationsTable < ActiveRecord::Migration
  def change
    create_table :locations, :force => true do |t|
      t.string     :type, :null => false, :default => 'Location'
      t.references :locatable,  :polymorphic => true

      t.decimal    :lat, :precision => 15, :scale => 10
      t.decimal    :lng, :precision => 15, :scale => 10

      t.string     :ip_address, :limit => 45

      t.string     :street
      t.string     :unit
      t.string     :city
      t.string     :us_state, :limit => 2
      t.string     :postal_code
      t.string     :country
      t.timestamps
    end
    add_index :locations, [:type]
    add_index :locations, [:locatable_id, :locatable_type]
    #remove_column :users, :location
  end
end