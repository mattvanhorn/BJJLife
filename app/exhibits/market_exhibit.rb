class MarketExhibit < BaseExhibit

  def self.applicable_to?(object)
    object.class.name == 'Market'
  end

  def as_option
    ("&nbsp;" * depth) + name
  end
end