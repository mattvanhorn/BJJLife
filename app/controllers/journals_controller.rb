class JournalsController < ApplicationController
  before_filter :authenticate_user!
  expose(:journals){ current_user.journals }
  expose(:journal)
  def new
    exhibit_exposed :journal
  end

  def show
    if journals.any?
      self.journal = journals.first
      exhibit_exposed :journal
    else
      redirect_to new_journal_url
    end
  end

  def create
    journal.user = current_user
    journal.save
    exhibit_exposed :journal
    respond_with :journal
  end
end

