# I'm in features/support/selectors.rb

module HtmlSelectorsHelper
  # Maps a name to a css selector.
  # Used to decouple the test language from the actual DOM specifics.
  #
  def selector_for(scope)
    case scope
    when /the body/
      "html > body"
    when "the form"
      "form"
    when "the navigation"
      'ul.navigation'
    when /the signup form/
      "#new_subscription.simple_form"
    when /the new account form/
      "#new_account .simple_form"
    when /the video (\d+) element/
      "#video_#{$1}"
    when "the header logo"
      "header h1"

    when "the academy guide link"
      I18n.t('subscriptions.new_stuff.academy_guide_link')

    when "the add academy link"
      I18n.t('academies.index.add_academy_link')

    when /([A-Z]{2})/
      ".us_state.#{$1.downcase}"
    when "academy listing"
      "ul.academies li"
    when /a blog entry/
      "article header h3"
    when "the first post listed"
      "article.post:first-child"
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)
