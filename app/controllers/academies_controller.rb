class AcademiesController < ApplicationController

  # expose(:academies) { Academy.all }

  protected

  def academies
    Academy.all
  end
  helper_method :academies
end