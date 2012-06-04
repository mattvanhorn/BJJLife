class CreateMakeVoteableTables < ActiveRecord::Migration
   def change
     create_table :votings do |t|
       t.string :voteable_type
       t.integer :voteable_id
       t.string :voter_type
       t.integer :voter_id
       t.boolean :up_vote, :null => false

       t.timestamps
    end

    add_column :users,  :up_votes,   :integer, :null => false, :default => 0
    add_column :users,  :down_votes, :integer, :null => false, :default => 0
    add_column :videos, :up_votes,   :integer, :null => false, :default => 0
    add_column :videos, :down_votes, :integer, :null => false, :default => 0
    add_column :posts,  :up_votes,   :integer, :null => false, :default => 0
    add_column :posts,  :down_votes, :integer, :null => false, :default => 0

    add_index :votings, [:voteable_type, :voteable_id]
    add_index :votings, [:voter_type, :voter_id]
    add_index :votings, [:voteable_type, :voteable_id, :voter_type, :voter_id], :name => "unique_voters", :unique => true

  end

end
