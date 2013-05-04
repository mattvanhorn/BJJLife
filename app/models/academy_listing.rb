class AcademyListing
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :academy
  attr_reader :academy_location

  # academy
  attribute :name, String
  attribute :instructor, String
  attribute :website, String
  attribute :email, String
  attribute :phone_number, String

  # location
  attribute :street, String
  attribute :unit, String
  attribute :city, String
  attribute :us_state, String
  attribute :postal_code, String
  attribute :country, String

  validates_with ContactMethodValidator
  validates_presence_of :name
  validates :email, :length => (3..254), :email => true, :allow_blank => true

  # The form objectss are never themselves persisted
  def persisted?
    false
  end

  def save
    build!
    if valid?
      persist!
      true
    else
      false
    end
  end

  def valid?
    @academy.try(:valid?)
  end

private
  def build!
    @academy = Academy.new(
      :name => name,
      :instructor => instructor,
      :website => website,
      :email => email,
      :phone_number => phone_number
    )
    @academy_location = @academy.build_location(
      :street => street,
      :unit => unit,
      :city => city,
      :us_state => us_state,
      :postal_code => postal_code,
      :country => country
    )
    @academy
  end

  def persist!
    @academy.save!
  end
end
