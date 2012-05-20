# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.delete_all
Video.find_or_create_by_name_and_url("Mitsuyo Maeda: The Origin of BJJ",                    "http://www.youtube.com/watch?v=m0fH_8kv7ac")
Video.find_or_create_by_name_and_url("Brazilian Jiu-Jitsu - The Gentle Art",                "http://www.youtube.com/watch?v=Gb-DpnC7zOg")
Video.find_or_create_by_name_and_url("Brazilian Jiu-Jitsu: The Game of Human Chess",        "http://www.youtube.com/watch?v=BRxrowcvOIw")
Video.find_or_create_by_name_and_url("Kron Gracie vs Vitor Estima World Jiu Jitsu Expo",    "http://www.youtube.com/watch?v=uHq5YjQBWNg")
Video.find_or_create_by_name_and_url("Jeff Glover vs Caio Terra World Jiu Jitsu Expo",      "http://www.youtube.com/watch?v=Z7eixxm5CLI")
Video.find_or_create_by_name_and_url("Kyra Gracie vs Alexis Davis World Jiu Jitsu expo",    "http://www.youtube.com/watch?v=BzYwGrR4_kg")
Video.find_or_create_by_name_and_url("Vitor Shaolin Ribiero - Spider Guard Sweep",          "http://www.youtube.com/watch?v=8p0eMDpeyrY")
Video.find_or_create_by_name_and_url("Shaolin teaches the 'Shaolin Sweep' from Half Guard", "http://www.youtube.com/watch?v=rJ_lOS70qT4")
Video.find_or_create_by_name_and_url("How to do the North South Choke by Marcelo Garcia",   "http://www.youtube.com/watch?v=RkFHJHC58qc")
Video.find_or_create_by_name_and_url("Marcelo Garcia vs Roger Gracie",                      "http://www.youtube.com/watch?v=_3hfXYoshzk")
