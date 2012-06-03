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
#  user_id     :integer
#
# Indexes
#
#  index_posts_on_blog_id  (blog_id)
#  index_posts_on_user_id  (user_id)
#

class Post < ActiveRecord::Base

  attr_accessible :title, :url, :description, :user_id

  belongs_to :blog
  belongs_to :user

  def publish!
    blog.add_entry(self)
  end

end
