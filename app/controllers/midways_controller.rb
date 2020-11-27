class MidwaysController < ApplicationController

  def index
  end

  def my_midways
    @midways = []

    current_user.midways.each do |midway|
      result = FoursquareService.new(venue_id: midway.venue).venue_info

      @midways << {name: result["name"],
        address: result["location"]["address"] +", "+ result["location"]["city"],
        photo: result["bestPhoto"]["prefix"] + result["bestPhoto"]["width"].to_s + "x" + result["bestPhoto"]["height"].to_s + result["bestPhoto"]["suffix"],
        midway: midway}
    end
  end

  def new
    @midway = Midway.new
    @friendships = current_user.friends
    total_users = []
    @friendships.each do |friendship|
      total_users.push(friendship.user)
      total_users.push(friendship.friend)
    end
    @friends = []
    total_users.each do |every_user|
      @friends.push every_user if every_user.id != current_user.id
    end
    @options = ["restaurant", "pub", "bar"]
  end

  def create
    #create the instance of the midway
    @midway = Midway.new(midway_params)
    @midway.user = current_user
    @midway.save

    #access the friend IDs from the form and create array of their locations
    friends = params[:midway][:friends][:participants].reject(&:blank?)
    friends.each do |id|
      MidwayParticipant.create!(user_id: id.to_i, midway_id: @midway.id)
    end
    participants = MidwayParticipant.where(midway_id: @midway.id)
    participants_locations = []
    participants_locations.push(@midway.user.location)
    participants.each do |participant|
      participants_locations.push(participant.user.location)
    end

    #accesses the time_option and the future_time
    time_option = params[:midway][:time_option].to_i
    future_time = params[:midway][:future_time].to_datetime.to_i

    #accesses the venue type the user wants
    @midway.venue_type = params[:midway][:venue_type].downcase

    #assigns the midpoint
    midpoint_service = MidpointService.new(addresses: participants_locations, time_option: time_option, future_time: future_time)
    midpoint_coordinates = midpoint_service.calculate
    @midpoint = "#{midpoint_coordinates[:lat]},#{midpoint_coordinates[:lng]}"
    @midway.midpoint = @midpoint
    @midway.save!
  end

  def edit
    #find midway and equate its assigned venue type to a category ID from Foursquare's API
    @midway = Midway.find(params[:id])
    venue_type_array = [{ type: "pub", categoryid: "4bf58dd8d48988d11b941735" }, { type: "restaurant", categoryid: "4d4b7105d754a06374d81259" }, { type: "nightclub", categoryid: "4bf58dd8d48988d11f941735" }, { type: "cinema", categoryid: "4bf58dd8d48988d17f941735" } ]
    chosen_category_id =  venue_type_array.find { |vt| vt[:type] == @midway.venue_type }[:categoryid]

    #find midpoint that was saved
    midpoint = @midway.midpoint

    @midpoint_hash = Hash.new
    @midpoint_hash[:lat] = midpoint.split(",")[0]
    @midpoint_hash[:lng] = midpoint.split(",")[1]

    # this queries the foursquare api and saves an ARRAY of venues in @venues
    foursquare_service = FoursquareService.new(location: midpoint, radius: 1000, categoryid: chosen_category_id)
    @venues = foursquare_service.find_venues
    @venue_hash = fetching_venue(@venues)

    # save all venue lat and long into array alled markers
    @markers = @venues.map do |venue|
      {
        lat: venue["location"]["lat"],
        lng: venue["location"]["lng"]
      }
    end
  end

  def fetching_venue(venues)
    venue_hash = []

    venues.each do |venue|
      venue_hash << {
      id: venue["id"],
      name: venue["name"],
      address: "#{venue["location"]["address"]}, #{venue["location"]["postalCode"]}, #{venue["location"]["city"]}",
      category: venue["categories"][0]["shortName"]
      }
    end
    venue_hash
  end

  # def show
  #   # this will be confirmation page
  # end

    private

  def midway_params
    params.require(:midway).permit(:friends, :time_option, :future_time)
  end

end
