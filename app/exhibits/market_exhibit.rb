class MarketExhibit < DisplayCase::Exhibit
  include ExhibitBaseHelper

  def self.applicable_to?(object)
    object.class.name == 'Market'
  end

  def to_s
    name
  end

  # def as_option
  #   ("&nbsp;" * depth) + name
  # end
end