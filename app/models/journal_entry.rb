class JournalEntry < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :journal
end
