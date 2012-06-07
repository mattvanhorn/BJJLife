class AcademyGroup
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :academies

  def initialize(grouping, academies)
    @grouping = grouping
    @academies = academies
  end

  def us_state
    @grouping
  end
end