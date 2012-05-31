class UserDecorator < Draper::Base
  decorates :user

  def greeting
    return unless user
    name = user.username.presence || 'there'
    h.content_tag(:p, "Hi #{name},")
  end
end