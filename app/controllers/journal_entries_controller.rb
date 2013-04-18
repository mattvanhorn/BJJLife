class JournalEntriesController < ApplicationController
  self.responder = ResourceResponder

  before_filter :authenticate_user!
  expose(:journal){ current_user.journal }
  expose(:journal_entries){ journal.entries }
  expose(:journal_entry)

  def new
    exhibit_exposed :journal, :journal_entry
  end

  def create
    journal_entry.save
    exhibit_exposed :journal_entry
    respond_with journal_entry
  end

  def show
    exhibit_exposed :journal_entry
  end
end
