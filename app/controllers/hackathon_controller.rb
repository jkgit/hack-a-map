require 'open-uri'
require 'json'
    
class HackathonController < ApplicationController
  def index
    @hackathons = JSON.parse(open("http://hackerleague.org/api/v1/hackathons.json").read)
    @countries = @hackathons.collect {|h| standardize_country(h["location"]["country"])}.uniq.sort
  end
  
  def standardize_country(country)
    # remove lead or trailing space
    country=country.strip
    
    # catch something like Australia and australia.  this only caps the first letter
    country[0]=country[0].capitalize
    
    # catch different names for a country, ie US, USA, United States, United States of Ameria
    if (country=="US" or country=="USA" or country=="United States")
      country="United States of America"
    end
    
    return country
  end
  
  def map
    @chosen_country = nil
    if (!params[:country].blank?)
        @chosen_country=standardize_country(params[:country])
    end
    @hackathons = JSON.parse(open("http://hackerleague.org/api/v1/hackathons.json").read)
    @hacks = []
    @hackathons.each do |h|
      country = standardize_country(h["location"]["country"])
      if (@chosen_country.nil?||country==@chosen_country)
        @hacks.push h
      end
    end 
  end
end
