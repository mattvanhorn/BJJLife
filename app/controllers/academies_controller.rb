class AcademiesController < ApplicationController
  expose(:academies_by_state)   { AcademyGroup.by_state }
  expose(:academies_by_country) { AcademyGroup.by_country }
  expose(:nearest_academies)  { Academy.near(identifiable_user.location, NEARBY_DISTANCE)||[] }
  expose(:search_results)     { Academy.near(query_location, NEARBY_DISTANCE)||[] }

  def index
    exhibit_exposed :nearest_academies, :academies_by_state, :academies_by_country
  end

  def search
    exhibit_exposed :search_results, :academies_by_state
  end

  private

  def query_location
    if (search_params = params[:academy_search])
      Geocoder.search(search_params[:location]).first.try(:coordinates)
    end
  end
end
