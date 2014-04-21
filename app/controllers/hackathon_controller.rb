require 'open-uri'
require 'json'
    
class HackathonController < ApplicationController
  # determine unique and sorted list of countries from the complete list of hackathons
  def index
    @hackathons = JSON.parse(open("http://hackerleague.org/api/v1/hackathons.json").read)
    @countries = @hackathons.collect {|h| standardize_country(h["location"]["country"])}.uniq.sort
  end
  
  def detail
    @chosen_hackathon_id = params[:id]
    @hackathon = JSON.parse(open("http://hackerleague.org/api/v1/hackathons/#{@chosen_hackathon_id}/hacks.json").read)
  end
  
  # make an effort to standardize country naming.  for instance australia==Australia and
  # US==USA==United States==United States of America.  this isn't complete obviously,
  # but is a start
  def standardize_country(country)
    # remove lead or trailing space
    country=country.strip
    
    # catch something like Australia and australia.  this only caps the first letter
    country[0]=country[0].capitalize
    
    # catch different names for a country, ie US, USA, United States, United States of Ameria
    if (country=="US" or country=="USA" or country=="United States")
      country="United States of America"
    end
    
    if (country=="UK" or country=="England")
      country="United Kingdom"
    end
    
    return country
  end
  
  # return a list of hackathons that match the given country name.  if no country
  # name given, return all hackathons
  def map
    @chosen_country = nil
    if (!params[:country].blank?)
        @chosen_country=standardize_country(params[:country])
    end
    @hackathons = JSON.parse(open("http://hackerleague.org/api/v1/hackathons.json").read)
    @filtered_hacks = []
    @hackathons.each do |h|
      country = standardize_country(h["location"]["country"])
      if (@chosen_country.nil?||country==@chosen_country)
        @filtered_hacks.push h
      end
    end 
  end
end
