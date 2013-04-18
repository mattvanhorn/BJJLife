class NewJournalPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.new_journal_path
  set_url URL
  set_url_matcher %r(#{URL})
end

class JournalPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.journal_path
  set_url URL
  set_url_matcher %r(#{URL})
end

class NewJournalEntryPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.new_journal_entry_path
  set_url URL
  set_url_matcher %r(#{URL})

  element :title_field, "input[name='journal_entry[title]']"
  element :body_field,  "textarea[name='journal_entry[body]']"
  element :post_entry_btn, "input[name='commit']"

end
