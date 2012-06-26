class AcademiesController < ApplicationController
  expose(:academies_by_state) { Academy.by_state.map{ |academy_group| exhibit(academy_group) } }
  expose(:nearest_academies)  { Academy.near(identifiable_user.location, NEARBY_DISTANCE)||[] }
  expose(:search_results)     { Academy.near(query_location, NEARBY_DISTANCE) }
  expose(:academy)

  def index
    exhibit_exposed :nearest_academies, :search_results
  end

  def new
    exhibit_exposed :academy
  end

  def create
    academy.save
    exhibit_exposed :academy
    respond_with academy
  end

  def search
    exhibit_exposed :nearest_academies, :search_results
  end

  private

  def query_location
    if (search_params = params[:academy_search])
      Geocoder.search(search_params[:location]).first.coordinates
    end
  end
end
