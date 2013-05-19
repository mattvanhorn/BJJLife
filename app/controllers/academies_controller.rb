class AcademiesController < ApplicationController

  expose(:academies){ AcademyPresenter.new(self, geocoder_origin) }

  private

  def geocoder_origin
    if (search_params = params[:academy_search])
      search_params[:location]
    else
      loc = identifiable_user.location
      [:city, :us_state, :country].map{|field| loc.try(:send, field)}.compact.join(', ').presence
    end
  end
end
