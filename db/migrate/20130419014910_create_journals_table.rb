class CreateJournalsTable < ActiveRecord::Migration
  def change
    create_table :journals, :force => true do |t|
      t.belongs_to :user
      t.string     :name, :null => false
      t.timestamps
    end
    add_index :journals, [:user_id]

    create_table :journal_entries, :force => true do |t|
      t.belongs_to :journal
      t.string :title
      t.text :body
      t.timestamps
    end
    add_index :journal_entries, [:journal_id]
  end

end


