class Post < ActiveRecord::Base

  attr_accessible :title, :url, :description

  belongs_to :blog

  def publish
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end