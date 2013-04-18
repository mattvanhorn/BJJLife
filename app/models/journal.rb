class Journal < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  has_many :entries, :class_name => 'JournalEntry', :order => 'created_at DESC'

end
