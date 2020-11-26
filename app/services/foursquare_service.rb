require 'rubygems'
require 'json'
require 'open-uri'

class FoursquareService

  def initialize(attributes = {})
    @location = attributes[:location]
    @radius = attributes[:radius]
    @categoryId = attributes[:categoryId]

    # if we weant to let them search themselves we can implement logic below to let them search
    #@category = attributes[:category]
  end

  def find_venues

    # find how to hide api key

    base_url = "https://api.foursquare.com/v2/venues/search?client_id=134CWXVHRK0JLFD0MX4DBFZI0K25FM0BTPIBQEB1P0ISMJXN&client_secret=VLPTGEZJTOCF4MQJOMQBZTS1AIJMLB3OKM0FXKOMLDOQKAEV"
    
    # Location comes as a string => "51.492035164043834,-0.15026726093747364"
    longitude = @location.split(",")[0]
    latitude = @location.split(",")[1]

    radius = @radius.to_s
    categoryId = @categoryId
    
    # v for version, current date works
    url = base_url + "&near=#{longitude},#{latitude}&radius=#{radius}&categoryId=#{categoryId}&v=20201126"
    json = JSON.parse(open(url).read)
    venues = json["response"]["venues"][0]

  end

end
