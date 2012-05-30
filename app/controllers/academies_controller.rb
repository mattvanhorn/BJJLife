class AcademiesController < ApplicationController

  expose(:academies_by_state) { Academy.by_state }
  expose(:academy)

  def create
    academy.save
    respond_with academy
  end

end