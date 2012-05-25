class Admin::AcademiesController < Admin::BaseController

  expose(:academies){ Academy.pending }
  expose(:academy)

  def publish
    academy.publish!
    respond_with :admin, academy
  end

end