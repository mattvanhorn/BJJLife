class AcademiesController < ApplicationController
  expose(:academies_by_state){ Academy.by_state.map{ |academy_group| exhibit(academy_group) } }
  expose(:academy)

  def index
    # render
  end

  def new
    exhibit_exposed :academy
  end

  def create
    academy.save
    exhibit_exposed :academy
    respond_with academy
  end

end