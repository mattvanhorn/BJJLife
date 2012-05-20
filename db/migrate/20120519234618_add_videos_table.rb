class AddVideosTable < ActiveRecord::Migration
  def change
    create_table :videos, :force => true do |t|
      t.string :name
      t.string :url
      t.timestamps
    end
  end
end