class PostDecorator < Draper::Base
  decorates :post

  def contributor
    post.user.try(:username) || 'anonymous'
  end
end