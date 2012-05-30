class Admin::AcademiesController < Admin::BaseController

  expose(:academies){ Academy.pending }
  expose(:academy)

  def index
    # just render
  end

  def publish
    academy.publish!
    respond_with :admin, academy
  end

end