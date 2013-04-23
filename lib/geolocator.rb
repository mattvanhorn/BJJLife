class Geolocator
  def initialize(cookies)
    yaml_str = cookies.signed[:location]
    @cookie_loc = ::YAML.load(yaml_str) unless yaml_str.blank?
  end

  def location
    unless @cookie_loc.blank?
      Location.new(:lat => @cookie_loc[:lat], :lng => @cookie_loc[:lng])
    end
  end

  def market
    Market.near(location).first
  end

end
