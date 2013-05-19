class Geolocator
  def initialize(cookies)
    yaml_str = cookies.signed[:location]
    @cookie_loc = ::YAML.load(yaml_str) unless yaml_str.blank?
  end

  def location
    unless @cookie_loc.blank?
      Location.new(@cookie_loc)
    end
  end

  def market
    Market.near(location).first
  end

end
