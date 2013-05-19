class AcademyPresenter
  include DisplayCase::ExhibitsHelper

  def initialize(context, location_str=nil)
    @context  = context
    @location = location_str
    @coords = Geocoder.search(@location).first.try(:coordinates) if @location
  end

  def by_state
    @_by_state ||= begin
      academies_hash = Academy.published.ordered_by_state.group_by(&:us_state)
      academy_groups = academies_hash.map{ |(us_state, academies)| AcademyGroup.new(Address::STATE_NAMES[us_state.upcase], us_state, academies) }
      exhibit(academy_groups, @context)
    end
  end

  def by_country
    @_by_country ||= begin
      academies_hash = Academy.published.ordered_by_country.group_by(&:country)
      academy_groups = academies_hash.map{ |(country, academies)| AcademyGroup.new(country, country, academies) }
      exhibit(academy_groups, @context)
    end
  end

  def nearest
    @_nearest ||= if @coords
      academies = Academy.published.near(@coords)
      academy_group = AcademyGroup.new("#{I18n.t('academies.index.nearest_academies')}: #{@location}", 'nearest', academies)
      exhibit([academy_group], @context)
    else
      []
    end
  end

end
