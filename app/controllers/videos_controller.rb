class VideosController < ApplicationController
  respond_to :html

  private

  def videos
    # Video.new(:name => "", :url => "")
    Video.new(:name => "Mitsuyo Maeda: The Origin of BJJ", :url => "m0fH_8kv7ac")
    Video.new(:name => "Brazilian Jiu-Jitsu - The Gentle Art", :url => "Gb-DpnC7zOg")
    Video.new(:name => "Brazilian Jiu-Jitsu: The Game of Human Chess", :url => "BRxrowcvOIw")
    Video.new(:name => "Kron Gracie vs Vitor Estima World Jiu Jitsu Expo", :url => "uHq5YjQBWNg")
    Video.new(:name => "Jeff Glover vs Caio Terra World Jiu Jitsu Expo", :url => "Z7eixxm5CLI")
    Video.new(:name => "Kyra Gracie vs Alexis Davis World Jiu Jitsu expo", :url => "BzYwGrR4_kg")
    Video.all
  end
  helper_method :videos

end