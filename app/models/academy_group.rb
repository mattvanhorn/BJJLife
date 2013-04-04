require "active_model/naming"
require "active_model/conversion"

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

  def persisted?
    academies.all? &:persisted?
  end

  def cache_key
    (academies.collect(&:cache_key) << us_state).hash
  end
end
