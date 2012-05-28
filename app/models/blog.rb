class Blog < ActiveRecord::Base
  attr_accessible :title
  attr_writer :post_source

  has_many :entries, :class_name => 'Post'

  def new_post(*args)
    post_source.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_entry(entry)
    entries << entry
  end

  private

  def post_source
    @post_source ||= Post.public_method(:new)
  end
end