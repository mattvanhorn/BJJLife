# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.find_or_create_by_name_and_url("Mitsuyo Maeda: The Origin of BJJ",                    "http://www.youtube.com/watch?v=m0fH_8kv7ac")
Video.find_or_create_by_name_and_url("Brazilian Jiu-Jitsu - The Gentle Art",                "http://www.youtube.com/watch?v=Gb-DpnC7zOg")
Video.find_or_create_by_name_and_url("Brazilian Jiu-Jitsu: The Game of Human Chess",        "http://www.youtube.com/watch?v=BRxrowcvOIw")
Video.find_or_create_by_name_and_url("Vitor Shaolin Ribiero - Spider Guard Sweep",          "http://www.youtube.com/watch?v=8p0eMDpeyrY")
Video.find_or_create_by_name_and_url("Shaolin teaches the 'Shaolin Sweep' from Half Guard", "http://www.youtube.com/watch?v=rJ_lOS70qT4")
Video.find_or_create_by_name_and_url("How to do the North South Choke by Marcelo Garcia",   "http://www.youtube.com/watch?v=RkFHJHC58qc")
Video.find_or_create_by_name_and_url("Marcelo Garcia vs Roger Gracie",                      "http://www.youtube.com/watch?v=_3hfXYoshzk")

Academy.find_or_create_by_name("Vitor Shaolin's Brazilian Jiu Jitsu") do |academy|
  academy.instructor   = "Vitor Shaolin"
  academy.street       = "780 8th Ave"
  academy.unit         = "3rd floor"
  academy.city         = "New York"
  academy.us_state     = "NY"
  academy.postal_code  = "10036"
  academy.email        = "tkd@4blackbelt.com"
  academy.phone_number = "(212) 957-4045"
  academy.website      = "http://bjjnewyorkcity.com"
end

Academy.find_or_create_by_name("Ralph Gracie San Francisco") do |academy|
  academy.instructor   = "Ralph Gracie / Kurt Osiander / Renan Silva"
  academy.street       = "1166 Howard Street"
  academy.city         = "San Francisco"
  academy.us_state     = "CA"
  academy.postal_code  = "94103"
  academy.phone_number = "(415) 552-4777"
  academy.website      = "http://ralphgraciesf.com"
end

Academy.find_or_create_by_name("Ralph Gracie Berkeley") do |academy|
  academy.instructor   = "Ralph Gracie / Eduardo Fraga / David Clahan"
  academy.street       = "1500 Ashby Avenue"
  academy.city         = "Berkeley"
  academy.us_state     = "CA"
  academy.postal_code  = "94703"
  academy.phone_number = "(510) 486-8000"
  academy.website      = "http://www.ralphgracieberkeley.com"
end
