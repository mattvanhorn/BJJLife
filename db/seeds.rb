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

record = Academy.find_or_create_by_name("Vitor Shaolin's Brazilian Jiu Jitsu") do |academy|
  academy.instructor   = "Vitor Shaolin"
  academy.email        = "tkd@4blackbelt.com"
  academy.phone_number = "(212) 957-4045"
  academy.website      = "http://bjjnewyorkcity.com"
end
record.location = AcademyLocation.create(
  :street       => "780 8th Ave",
  :unit         => "3rd floor",
  :city         => "New York",
  :us_state     => "NY",
  :postal_code  => "10036"
)

record = Academy.find_or_create_by_name("Ralph Gracie San Francisco") do |academy|
  academy.instructor   = "Ralph Gracie / Kurt Osiander / Renan Silva"
  academy.phone_number = "(415) 552-4777"
  academy.website      = "http://ralphgraciesf.com"
end
record.location = AcademyLocation.create(
  :street       => "1166 Howard Street",
  :city         => "San Francisco",
  :us_state     => "CA",
  :postal_code  => "94103"
)

record = Academy.find_or_create_by_name("Ralph Gracie Berkeley") do |academy|
  academy.instructor   = "Ralph Gracie / Eduardo Fraga / David Clahan"
  academy.phone_number = "(510) 486-8000"
  academy.website      = "http://www.ralphgracieberkeley.com"
end
record.location = AcademyLocation.create(
  :street       => "1500 Ashby Avenue",
  :city         => "Berkeley",
  :us_state     => "CA",
  :postal_code  => "94703"
)

record = Academy.find_or_create_by_name("NYMAG Naples MMA, BJJ, Muay Thai Kickbxing") do |academy|
  academy.phone_number = "(239) 598 4466"
  academy.website      = "http://www.NYMAGnaples.com"
  academy.email        = "NYMAGnaples@gmail.com"
  academy.instructor   = "Gene Simco (Black Belt 2nd degree)"
end
record.location = AcademyLocation.create(
  :street       => "Jabz Gym Naples 2151 Trade Center Way",
  :city         => "Naples",
  :us_state     => "FL",
  :postal_code  => "34109"
)

record = Academy.find_or_create_by_name("South Elgin Budokan Martial Arts & Fitness") do |academy|
  academy.phone_number = "847-888-8866"
  academy.website      = "http://www.southelginbudokan.com"
  academy.email        = "southelginbudokan@att.net"
  academy.instructor   = "T. O'Shaughnessy (rank: 8th Dan Judo)"
end
record.location = AcademyLocation.create(
  :street       => "959 N La Fox St",
  :city         => "South Elgin",
  :us_state     => "IL",
  :postal_code  => "60177"
)

record = Academy.find_or_create_by_name("Carlson Gracie Team Northern Virginia Academy") do |academy|
  academy.phone_number = "703-986-9374"
  academy.website      = "http://www.bjjVA.com"
  academy.email        = "jiujitsuworld@gmail.com"
  academy.instructor   = "Ivan Rios (rank: Black Belt)"
end
record.location = AcademyLocation.create(
  :street       => "8253 Backlick Rd. #D",
  :city         => "Lorton",
  :us_state     => "VA",
  :postal_code  => "22079"
)

record = Academy.find_or_create_by_name("Lockjaw Jiu-Jitsu Academy") do |academy|
  academy.phone_number = "928-502-0195"
  academy.website      = "http://www.internationaljujitsu.com"
  academy.email        = "ija@internationaljujitsu.com"
  academy.instructor   = "Ralph Villa (rank: 7th Degree Black Belt)"
end
record.location = AcademyLocation.create(
  :street       => "240 West Main Street",
  :city         => "Somerton",
  :us_state     => "AZ",
  :postal_code  => "85350"
)

record = Academy.find_or_create_by_name("Lockjaw Brazilian Jiu-Jitsu") do |academy|
  academy.phone_number = "928-502-0195"
  academy.website      = "http://www.internationaljujitsu.com"
  academy.email        = "ija@internationaljujitsu.com"
  academy.instructor   = "Ralph Villa (rank: BJJ Brown Belt)"
end
record.location = AcademyLocation.create(
  :street       => "240 West Main Street",
  :city         => "Somerton",
  :us_state     => "AZ",
  :postal_code  => "85350"
)

record = Academy.find_or_create_by_name("Rockville Martial Arts") do |academy|
  academy.phone_number = "301-251-4000"
  academy.website      = "http://www.facebook.com/RockvilleBrazilianJiuJitsu"
  academy.email        = "zimmed03@gmail.com"
  academy.instructor   = "David Zimmerman (rank: 4 Stripe Blue)"
end
record.location = AcademyLocation.create(
  :street       => "1331-O Rockville Pike",
  :city         => "Rockville",
  :us_state     => "MD",
  :postal_code  => "20852"
)

record = Academy.find_or_create_by_name("Reaction MMA and Brazilian Jiu-Jitsu") do |academy|
  academy.phone_number = "8599132013"
  academy.website      = "http://www.teamreactionmma.com"
  academy.email        = "robsteel@live.com"
  academy.instructor   = "Rob Nickerson (rank: Brown)"
end
record.location = AcademyLocation.create(
  :street       => "125 Eisenhour Court",
  :city         => "Nicholasville",
  :us_state     => "KY",
  :postal_code  => "40503"
)

record = Academy.find_or_create_by_name("Huron Valley Jiu Jitsu") do |academy|
  academy.phone_number = "248-640-5239"
  academy.website      = "http://www.hvjj.webstarts.com"
  academy.email        = "hvjj@comcast.net"
  academy.instructor   = "Greg Breen (rank: Four stripe blue)"
end
record.location = AcademyLocation.create(
  :street       => "302 highland ave",
  :city         => "milford",
  :us_state     => "MI",
  :postal_code  => "48381"
)

record = Academy.find_or_create_by_name("Manassas Mixed Martial Arts") do |academy|
  academy.phone_number = "703-594-6220"
  academy.website      = "http://www.ManassasMMA.com"
  academy.email        = "manassasmma@gmail.com"
  academy.instructor   = "Dave Trader (rank: Black Belt - 2nd degree)"
end
record.location = AcademyLocation.create(
  :street       => "10521 Croatia Way",
  :city         => "Manassas",
  :us_state     => "VA",
  :postal_code  => "20109"
)

record = Academy.find_or_create_by_name("Gracie Jiu-Jitsu Training Center") do |academy|
  academy.phone_number = "801-347-3471"
  academy.website      = "http://www.graciejiu-jitsu.us"
  academy.email        = "graciejiujitsu@instructor.net"
  academy.instructor   = "Michael A. Hermosillo Sr. (rank: 3rd Degree Black Belt)"
end
record.location = AcademyLocation.create(
  :street       => "9854 South 700 East",
  :city         => "Sandy",
  :us_state     => "UT",
  :postal_code  => "84070"
)

record = Academy.find_or_create_by_name("Renzo Gracie Academy New York City") do |academy|
  academy.phone_number = "212.279.6724"
  academy.website      = "www.renzogracie.com"
  academy.email        = "info@renzogracie.com"
  academy.instructor   = "Renzo Gracie"
end
record.location = AcademyLocation.create(
  :street       => "224 West 30th Street",
  :city         => "New York",
  :us_state     => "NY",
  :postal_code  => "10001"
)

record = Academy.find_or_create_by_name("Renzo Gracie Academy Holmdel") do |academy|
  academy.phone_number = "732.888.9399"
  academy.website      = "http://www.renzogracienj.com"
  academy.email        = "info@renzogracienj.com"
  academy.instructor   = "Rolles Gracie"
end
record.location = AcademyLocation.create(
  :street       => "Kohl's Plaza 2145 Highway 35",
  :city         => "Holmdel",
  :us_state     => "NJ",
  :postal_code  => "07733"
)

record = Academy.find_or_create_by_name("Renzo Gracie Academy Stamford") do |academy|
  academy.website      = "http://www.graciect.com"
  academy.email        = "info@graciect.com"
  academy.instructor   = "Igor and Gregor Gracie"
end
record.location = AcademyLocation.create(
  :street       => "103 Atlantic St.",
  :city         => "Stamford",
  :us_state     => "CT",
  :postal_code  => "06901"
)

record = Academy.find_or_create_by_name("Marcelo Garcia's New York City BJJ Academy") do |academy|
  academy.phone_number = "212.947.0300"
  academy.website      = "http://www.marcelogarciajj.com/"
  academy.email        = "nyc@marcelogarciajj.com"
  academy.instructor   = "Marcelo Garcia"
end
record.location = AcademyLocation.create(
  :street       => "25 W 36th St.",
  :unit         => "6th Floor",
  :city         => "New York",
  :us_state     => "NY",
  :postal_code  => "10018"
)

# record = Academy.find_or_create_by_name("") do |academy|
#   academy.street       = ""
#   academy.unit         = ""
#     :city         => ""
#     :us_state     => ""
#     :postal_code  => ""
#   academy.website      = ""
#   academy.email        = ""
#   academy.instructor   = ""
# end

Blog.find_or_create_by_title('Training')

Category.find_or_create_by_name('Seminars')
Category.find_or_create_by_name('Classes')
Category.find_or_create_by_name('Private Lessons')

national_market = Market.find_or_create_by_name('National')
national_market.children.find_or_create_by_name('New York'     , :location => Location.new(:postal_code => '10199'))
national_market.children.find_or_create_by_name('Los Angeles'  , :location => Location.new(:postal_code => '90052'))
national_market.children.find_or_create_by_name('Chicago'      , :location => Location.new(:postal_code => '60607'))
national_market.children.find_or_create_by_name('Houston'      , :location => Location.new(:postal_code => '77201'))
national_market.children.find_or_create_by_name('Philadelphia' , :location => Location.new(:postal_code => '19104'))
national_market.children.find_or_create_by_name('Phoenix'      , :location => Location.new(:postal_code => '85026'))
national_market.children.find_or_create_by_name('San Diego'    , :location => Location.new(:postal_code => '92199'))
national_market.children.find_or_create_by_name('Dallas'       , :location => Location.new(:postal_code => '75260'))
national_market.children.find_or_create_by_name('San Jose'     , :location => Location.new(:postal_code => '95101'))
national_market.children.find_or_create_by_name('Jacksonville' , :location => Location.new(:postal_code => '32203'))
national_market.children.find_or_create_by_name('Indianapolis' , :location => Location.new(:postal_code => '46206'))
national_market.children.find_or_create_by_name('San Francisco', :location => Location.new(:postal_code => '94103'))
national_market.children.find_or_create_by_name('Austin'       , :location => Location.new(:postal_code => '78710'))
national_market.children.find_or_create_by_name('Columbus'     , :location => Location.new(:postal_code => '43216'))
national_market.children.find_or_create_by_name('Charlotte'    , :location => Location.new(:postal_code => '28228'))
national_market.children.find_or_create_by_name('Detroit'      , :location => Location.new(:postal_code => '48233'))
national_market.children.find_or_create_by_name('Boston'       , :location => Location.new(:postal_code => '02205'))
national_market.children.find_or_create_by_name('Seattle'      , :location => Location.new(:postal_code => '98108'))
national_market.children.find_or_create_by_name('Washington DC', :location => Location.new(:postal_code => '20090'))
national_market.children.find_or_create_by_name('Denver'       , :location => Location.new(:postal_code => '80202'))
national_market.children.find_or_create_by_name('Portland'     , :location => Location.new(:postal_code => '97208'))
national_market.children.find_or_create_by_name('Las Vegas'    , :location => Location.new(:postal_code => '89199'))
national_market.children.find_or_create_by_name('Miami'        , :location => Location.new(:postal_code => '33152'))
national_market.children.find_or_create_by_name('New Orleans'  , :location => Location.new(:postal_code => '70113'))
national_market.children.find_or_create_by_name('Honolulu'     , :location => Location.new(:postal_code => '96820'))