# encoding: utf-8

class AcademySection < SitePrism::Section
  element :name, 'div.name'
  element :address, 'div.address'
  element :contact, 'div.contact'
end

class StateSection < SitePrism::Section
  elements :academies, "ul.academies li"
  def has_academy?(name)
    academies.detect{|a|a.has_text? name}.present?
  end
end

class AcademiesPage < SitePrism::Page
  include ::CommonPageBehavior
  init_url_and_matcher(Rails.application.routes.url_helpers.academies_path)

  sections :us_states, StateSection, "div.us_state"
  sections :academies, AcademySection, "ul.academies li"
  section :nearest, StateSection, "div.nearest"

  element :search_field, "input[name='academy_search[location]']"
  element :search_btn, "input[name='commit']"

  def state_section(abbr)
    abbr.downcase!
    StateSection.new self, find_first("div.us_state.#{abbr}")
  end

end

class NewAcademyPage < SitePrism::Page
  include CommonPageBehavior
  init_url_and_matcher(Rails.application.routes.url_helpers.new_academy_path)

  element :name_field,        "input[name='academy_listing[name]']"
  element :instructor_field,  "input[name='academy_listing[instructor]']"
  element :street_field,      "input[name='academy_listing[street]']"
  element :unit_field,        "input[name='academy_listing[unit]']"
  element :city_field,        "input[name='academy_listing[city]']"
  element :us_state_field,    "input[name='academy_listing[us_state]']"
  element :postal_code_field, "input[name='academy_listing[postal_code]']"
  element :country_field,     "input[name='academy_listing[country]']"
  element :email_field,       "input[name='academy_listing[email]']"
  element :phone_number_field,"input[name='academy_listing[phone_number]']"
  element :website_field,     "input[name='academy_listing[website]']"
  element :create_academy_btn,"input[name='commit']"

  def add_us_academy
    populate_form(
      :name =>         "Vitor Shaolin's Brazilian Jiu Jitsu",
      :instructor =>   "Vitor Shaolin",
      :street =>       "780 8th Ave",
      :unit =>         "3rd floor",
      :city =>         "New York",
      :us_state =>     "NY",
      :postal_code =>  "10036",
      :email =>        "tkd@4blackbelt.com",
      :phone_number => "(212) 957-4045",
      :website =>      "http://bjjnewyorkcity.com/"
    )
    create_academy_btn.click
  end
  alias :add_academy :add_us_academy

  def add_brazilian_academy
    populate_form(
      :name =>         "Nova União (Academia Upper)",
      :instructor =>   "André Pederneires",
      :street =>       "Rua Marques de Abrante, 88",
      :city =>         "Rio de Janeiro",
      :us_state =>     "RJ",
      :postal_code =>  "22230-061",
      :country =>      "Brazil",
      :phone_number => "(21) 2553 3485"
    )
    create_academy_btn.click
  end

  private

  def populate_form(attribs)
    attribs.each_pair do |name, value|
      send("#{name}_field").set value
    end
  end
end

module Admin
  class AcademiesPage < SitePrism::Page
    include CommonPageBehavior
    init_url_and_matcher(Rails.application.routes.url_helpers.admin_academies_path)

    elements :publish_links, "ul.academies li>a"
  end
end
