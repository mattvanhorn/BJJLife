# I'm in features/support/selectors.rb

module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the body/
      "html > body"
    when /the signup form/
      "#new_subscription.simple_form"
    when /the video (\d+) element/
      "#video_#{$1}"
    when "the header logo"
      "header h1"
    when "the academy guide link"
      I18n.t('subscriptions.new_stuff.academy_guide_link')
    when "the add academy link"
      I18n.t('add_academy_link')
    when /([A-Z]{2})/
      ".us_state.#{$1.downcase}"
    when "academy listing"
      "ul.academies li"
    when /a blog entry/
      "article header h3"
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)
