# == Schema Information
#
# Table name: blogs
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Blog < ActiveRecord::Base
  attr_accessible :title
  attr_writer :post_source

  has_many :entries, :class_name => 'Post', :order => 'created_at DESC'

  def add_entry(entry)
    entries << entry
  end

end
