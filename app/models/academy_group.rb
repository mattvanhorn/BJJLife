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

  def self.create_from(academies)
    academies.group_by(&:region).map{ |(region, academies)| new(region, academies) }
  end

  def self.by_country
    create_from Academy.ordered_by_country
  end

  def self.by_state
    create_from Academy.ordered_by_state
  end

  def region
    @grouping
  end
  alias :us_state :region
  alias :country  :region

  def persisted?
    academies.all? &:persisted?
  end

  def cache_key
    (academies.collect(&:cache_key) << us_state).hash
  end
end
