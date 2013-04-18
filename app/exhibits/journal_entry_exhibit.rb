class JournalEntryExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'JournalEntry'
  end

  def render(template)
    if template.controller_name == 'journals'
      template.render(partial: 'journal_entries/link', locals: {entry: self})
    else
      body
    end
  end

end
