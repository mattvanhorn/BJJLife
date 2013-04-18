class JournalExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object, context)
    object.class.name == 'Journal'
  end

  exhibit_query :entries

end
