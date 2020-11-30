require 'rubygems'
require 'json'
require 'open-uri'

class FoursquareService

  def initialize(attributes = {})
    @location = attributes[:location]
    @radius = attributes[:radius]
    @venue_type = attributes[:venue_type]
    @photo_reference = attributes[:photo_reference]

    # if we weant to let them search themselves we can implement logic below to let them search
    #@venue_type = attributes[:venue_type]
  end

  def find_venues

    # find how to hide api key
    # api_key = ENV["GOOGLE_API_KEY"]

    base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"

    # Location comes as a string => "51.492035164043834,-0.15026726093747364"
    longitude = @location.split(",")[0]
    latitude = @location.split(",")[1]

    radius = @radius.to_s
    venue_type = @venue_type

    # v for version, current date works
    url = base_url + "location=#{longitude},#{latitude}&radius=#{radius}&type=#{venue_type}&key=AIzaSyDFvyNLsoIQsADW5U0uePwiuLjbHg9CnBs"
    json = JSON.parse(open(url).read)
    venues = []
    json["results"].each do |result|
      if result["business_status"] == "OPERATIONAL"
        venues.push(result)
      end
    end

    return venues
  end

  def search_photo
    url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{@photo_reference}&key=AIzaSyDFvyNLsoIQsADW5U0uePwiuLjbHg9CnBs"
    return url
  end
end
