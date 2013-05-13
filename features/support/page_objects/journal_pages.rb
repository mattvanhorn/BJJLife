class NewJournalPage < SitePrism::Page
  include ::CommonPageBehavior
  init_url_and_matcher(Rails.application.routes.url_helpers.new_journal_path)
end

class JournalPage < SitePrism::Page
  include ::CommonPageBehavior
  init_url_and_matcher(Rails.application.routes.url_helpers.journal_path)
end

class NewJournalEntryPage < SitePrism::Page
  include ::CommonPageBehavior
  init_url_and_matcher(Rails.application.routes.url_helpers.new_journal_entry_path)

  element :title_field, "input[name='journal_entry[title]']"
  element :body_field,  "textarea[name='journal_entry[body]']"
  element :post_entry_btn, "input[name='commit']"
end
