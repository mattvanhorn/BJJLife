# == Schema Information
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  blog_id     :integer
#  title       :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Post < ActiveRecord::Base

  attr_accessible :title, :url, :description

  belongs_to :blog

  def publish!
    blog.add_entry(self)
  end

end
