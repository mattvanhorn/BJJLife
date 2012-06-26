class AcademySearch
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :location

  def persisted?
    false
  end
end