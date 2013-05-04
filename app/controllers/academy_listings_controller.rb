class AcademyListingsController < ApplicationController

  expose(:academy_listing)

  def new
    exhibit_exposed :academy_listing
  end

  def create
    academy_listing.save
    exhibit_exposed :academy_listing
    respond_with academy_listing
  end

end
