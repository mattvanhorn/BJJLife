class CreateAcademiesTable < ActiveRecord::Migration
  def change
    create_table :academies, :force => true do |t|
      t.string :name, :null => false
      t.string :instructor
      t.string :street
      t.string :unit
      t.string :city
      t.string :us_state, :limit => 2
      t.string :postal_code
      t.string :website
      t.string :email
      t.string :phone_number
      t.timestamps
    end
  end
end