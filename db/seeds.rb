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

Academy.find_or_create_by_name("NYMAG Naples MMA, BJJ, Muay Thai Kickbxing") do |academy|
  academy.street       = "Jabz Gym Naples 2151 Trade Center Way"
  academy.city         = "Naples"
  academy.us_state     = "FL"
  academy.postal_code  = "34109"
  academy.phone_number = "(239) 598 4466"
  academy.website      = "http://www.NYMAGnaples.com"
  academy.email        = "NYMAGnaples@gmail.com"
  academy.instructor   = "Gene Simco (Black Belt 2nd degree)"
end

Academy.find_or_create_by_name("South Elgin Budokan Martial Arts & Fitness") do |academy|
  academy.street       = "959 N La Fox St"
  academy.city         = "South Elgin"
  academy.us_state     = "IL"
  academy.postal_code  = "60177"
  academy.phone_number = "847-888-8866"
  academy.website      = "http://www.southelginbudokan.com"
  academy.email        = "southelginbudokan@att.net"
  academy.instructor   = "T. O'Shaughnessy (rank: 8th Dan Judo)"
end

Academy.find_or_create_by_name("Carlson Gracie Team Northern Virginia Academy") do |academy|
  academy.street       = "8253 Backlick Rd. #D"
  academy.city         = "Lorton"
  academy.us_state     = "VA"
  academy.postal_code  = "22079"
  academy.phone_number = "703-986-9374"
  academy.website      = "http://www.bjjVA.com"
  academy.email        = "jiujitsuworld@gmail.com"
  academy.instructor   = "Ivan Rios (rank: Black Belt)"
end

Academy.find_or_create_by_name("Lockjaw Jiu-Jitsu Academy") do |academy|
  academy.street       = "240 West Main Street"
  academy.city         = "Somerton"
  academy.us_state     = "AZ"
  academy.postal_code  = "85350"
  academy.phone_number = "928-502-0195"
  academy.website      = "http://www.internationaljujitsu.com"
  academy.email        = "ija@internationaljujitsu.com"
  academy.instructor   = "Ralph Villa (rank: 7th Degree Black Belt)"
end

Academy.find_or_create_by_name("Lockjaw Brazilian Jiu-Jitsu") do |academy|
  academy.street       = "240 West Main Street"
  academy.city         = "Somerton"
  academy.us_state     = "AZ"
  academy.postal_code  = "85350"
  academy.phone_number = "928-502-0195"
  academy.website      = "http://www.internationaljujitsu.com"
  academy.email        = "ija@internationaljujitsu.com"
  academy.instructor   = "Ralph Villa (rank: BJJ Brown Belt)"
end

Academy.find_or_create_by_name("Rockville Martial Arts") do |academy|
  academy.street       = "1331-O Rockville Pike"
  academy.city         = "Rockville"
  academy.us_state     = "MD"
  academy.postal_code  = "20852"
  academy.phone_number = "301-251-4000"
  academy.website      = "http://www.facebook.com/RockvilleBrazilianJiuJitsu"
  academy.email        = "zimmed03@gmail.com"
  academy.instructor   = "David Zimmerman (rank: 4 Stripe Blue)"
end

Academy.find_or_create_by_name("Reaction MMA and Brazilian Jiu-Jitsu") do |academy|
  academy.street       = "125 Eisenhour Court"
  academy.city         = "Nicholasville"
  academy.us_state     = "KY"
  academy.postal_code  = "40503"
  academy.phone_number = "8599132013"
  academy.website      = "http://www.teamreactionmma.com"
  academy.email        = "robsteel@live.com"
  academy.instructor   = "Rob Nickerson (rank: Brown)"
end

Academy.find_or_create_by_name("Huron Valley Jiu Jitsu") do |academy|
  academy.street       = "302 highland ave"
  academy.city         = "milford"
  academy.us_state     = "MI"
  academy.postal_code  = "48381"
  academy.phone_number = "248-640-5239"
  academy.website      = "http://www.hvjj.webstarts.com"
  academy.email        = "hvjj@comcast.net"
  academy.instructor   = "Greg Breen (rank: Four stripe blue)"
end

Academy.find_or_create_by_name("Manassas Mixed Martial Arts") do |academy|
  academy.street       = "10521 Croatia Way"
  academy.city         = "Manassas"
  academy.us_state     = "VA"
  academy.postal_code  = "20109"
  academy.phone_number = "703-594-6220"
  academy.website      = "http://www.ManassasMMA.com"
  academy.email        = "manassasmma@gmail.com"
  academy.instructor   = "Dave Trader (rank: Black Belt - 2nd degree)"
end

Academy.find_or_create_by_name("Gracie Jiu-Jitsu Training Center") do |academy|
  academy.street       = "9854 South 700 East"
  academy.city         = "Sandy"
  academy.us_state     = "UT"
  academy.postal_code  = "84070"
  academy.phone_number = "801-347-3471"
  academy.website      = "http://www.graciejiu-jitsu.us"
  academy.email        = "graciejiujitsu@instructor.net"
  academy.instructor   = "Michael A. Hermosillo Sr. (rank: 3rd Degree Black Belt)"
end

Academy.find_or_create_by_name("Renzo Gracie Academy New York City") do |academy|
  academy.street       = "224 West 30th Street"
  academy.city         = "New York"
  academy.us_state     = "NY"
  academy.postal_code  = "10001"
  academy.phone_number = "212.279.6724"
  academy.website      = "www.renzogracie.com"
  academy.email        = "info@renzogracie.com"
  academy.instructor   = "Renzo Gracie"
end

Academy.find_or_create_by_name("Renzo Gracie Academy Holmdel") do |academy|
  academy.street       = "Kohl's Plaza 2145 Highway 35"
  academy.city         = "Holmdel"
  academy.us_state     = "NJ"
  academy.postal_code  = "07733"
  academy.phone_number = "732.888.9399"
  academy.website      = "http://www.renzogracienj.com"
  academy.email        = "info@renzogracienj.com"
  academy.instructor   = "Rolles Gracie"
end

Academy.find_or_create_by_name("Renzo Gracie Academy Stamford") do |academy|
  academy.street       = "103 Atlantic St."
  academy.city         = "Stamford"
  academy.us_state     = "CT"
  academy.postal_code  = "06901"
  academy.website      = "http://www.graciect.com"
  academy.email        = "info@graciect.com"
  academy.instructor   = "Igor and Gregor Gracie"
end

Academy.find_or_create_by_name("Marcelo Garcia's New York City BJJ Academy") do |academy|
  academy.street       = "25 W 36th St."
  academy.unit         = "6th Floor"
  academy.city         = "New York"
  academy.us_state     = "NY"
  academy.postal_code  = "10018"
  academy.phone_number = "212.947.0300"
  academy.website      = "http://www.marcelogarciajj.com/"
  academy.email        = "nyc@marcelogarciajj.com"
  academy.instructor   = "Marcelo Garcia"
end

# Academy.find_or_create_by_name("") do |academy|
#   academy.street       = ""
#   academy.unit         = ""
#   academy.city         = ""
#   academy.us_state     = ""
#   academy.postal_code  = ""
#   academy.website      = ""
#   academy.email        = ""
#   academy.instructor   = ""
# end

Blog.find_or_create_by_title('Training')

Category.find_or_create_by_name('Seminars')
Category.find_or_create_by_name('Classes')
Category.find_or_create_by_name('Private Lessons')
