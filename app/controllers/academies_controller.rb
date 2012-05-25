class AcademiesController < ApplicationController

  expose(:academies_by_state) { Academy.published.order('us_state, name').group_by{|a|a.us_state} }
  expose(:academy)

  def create
    academy.save
    respond_with academy
  end

end