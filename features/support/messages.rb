# I'm in features/support/selectors.rb

module I18nMessagesHelper
  def message_for(desc)
    case desc
    when "nickname"
      'activerecord.attributes.user.username'
    when "teacher"
      'activerecord.attributes.user.teacher'
    when "location"
      'activerecord.attributes.user.location'
    when "rank"
      'activerecord.attributes.user.rank'

    when /the missing password/
      'sign_in.password_missing'
    when /the missing email$/
      'sign_in.email_missing'
    when /the missing email and password/
      'sign_in.email_and_password_missing'
    when /the invalid credentials/
      'sign_in.invalid_credentials'
    when "the thank you"
      'subscriptions.thanks.message_html'
    when "the explanatory"
      'landing_page.explanation_html'
    else
      raise "Can't find mapping from \"#{desc}\" to a message key.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(I18nMessagesHelper)

