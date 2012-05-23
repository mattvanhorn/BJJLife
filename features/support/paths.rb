module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   Given /^I am on (.*)$/ do |page_name|
  #
  # step definition in navigation_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the subscription thank you page/
      thanks_subscriptions_path

    when /the landing page for option (a|b)/
      landing_path(:image => $1)

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)