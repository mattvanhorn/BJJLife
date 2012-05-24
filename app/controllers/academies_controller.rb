class AcademiesController < ApplicationController
  respond_to :html

  expose(:academies_by_state) { Academy.order('us_state, name').group_by{|a|a.us_state} }
  expose(:academy)

  def create
    academy.save
    respond_with :academy, :location => academies_url
  end

end