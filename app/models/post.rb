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
#  up_votes    :integer         default(0), not null
#  down_votes  :integer         default(0), not null
#
# Indexes
#
#  index_posts_on_blog_id  (blog_id)
#  index_posts_on_user_id  (user_id)
#

require 'confidence_interval'

class Post < ActiveRecord::Base
  include ConfidenceInterval
  make_voteable

  attr_writer :comment_source
  attr_accessible :title, :url, :description, :user_id

  belongs_to :blog
  belongs_to :user
  has_many :comments

  def publish!
    blog.add_entry(self)
  end

  def new_comment(*args)
    comment_source.call(*args).tap do |comment|
      comment.post = self
    end
  end

  private

  def comment_source
    @comment_source ||= Comment.public_method(:new)
  end
end

