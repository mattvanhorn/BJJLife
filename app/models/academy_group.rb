require "active_model/naming"
require "active_model/conversion"

class AcademyGroup
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :academies, :label, :anchor

  def initialize(label, anchor, academies)
    @label = label
    @anchor = anchor.downcase.gsub(/\W+/,'-')
    @academies = academies
  end

  def persisted?
    academies.all? &:persisted?
  end

  def cache_key
    (academies.collect(&:cache_key) << label << anchor).hash
  end
end
