module Helpers
  def strip_tags(text)
    HTML::FullSanitizer.new.sanitize(text)
  end

end
World(Helpers)
