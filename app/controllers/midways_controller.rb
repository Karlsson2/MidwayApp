class MidwaysController < ApplicationController

  def index
  end

  def my_midways
    @midways = current_user.midways
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
    @venue = Venue.new
    @venue.save!

    #create the instance of the midway
    @midway = Midway.new(midway_params)
    @midway.user = current_user
    @midway.venue = @venue
    @midway.save!

    #access the friend IDs from the form and create array of their locations
    friends = params[:midway][:friends][:participants].reject(&:blank?)
    friends.each do |id|
      MidwayParticipant.create!(user_id: id.to_i, midway_id: @midway.id)
    end
    MidwayParticipant.create!(user_id: current_user.id, midway_id: @midway.id)
    participants = MidwayParticipant.where(midway_id: @midway.id)
    participants_locations = []
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
    midpoint_coordinates = midpoint_service.calculate[0]
    @midpoint = "#{midpoint_coordinates[:lat]},#{midpoint_coordinates[:lng]}"
    @midway.midpoint = @midpoint
    @midway.save!

    #assigns a duration to each Midway Participant
    durations = midpoint_service.calculate[1]
    participants.each_with_index do |participant, index|
      participant.duration_to_midpoint = durations[index]
      participant.save!
    end

    #redirect straight to edit page to pick the venue
    redirect_to edit_midway_path(@midway.id)
  end

  def edit
    #find midway and equate its assigned venue type to a category ID from Foursquare's API
    @midway = Midway.find(params[:id])

    #find midpoint that was saved
    midpoint = @midway.midpoint
    #find venue type that was saved
    venue_type = @midway.venue_type

    @midpoint_hash = Hash.new
    @midpoint_hash[:lat] = midpoint.split(",")[0]
    @midpoint_hash[:lng] = midpoint.split(",")[1]

    # this queries the foursquare api and saves an ARRAY of venues in @venues
    foursquare_service = FoursquareService.new(location: midpoint, radius: 1000, venue_type: venue_type)
    @venues = foursquare_service.find_venues
    @venue_hash = fetching_venue(@venues)

    # save all venue lat and long into array alled markers
    @markers = @venues.map do |venue|
      {
        lat: venue["geometry"]["location"]["lat"],
        lng: venue["geometry"]["location"]["lng"]
      }
    end
  end

  def update
    @midway = Midway.find(params[:id])

    @midway.venue.update(venue_params)
    @midway.venue.save!

    @midway.save!
    redirect_to midway_path(@midway.id)
  end

  def show
    @midway = Midway.find(params[:id])
    @venue = @midway.venue

    @venue_hash = Hash.new
    @venue_hash[:name] = @venue.name
    @venue_hash[:address] = @venue.address
    @venue_hash[:photo] = @venue.photo_url
    @venue_hash[:lat] = @venue.lat
    @venue_hash[:lng] = @venue.lng

    @participants = MidwayParticipant.where(midway_id: @midway.id)
    addresses = @participants.map { |participant| participant.user.location}
    addresses_coordinates = convert_to_geocode(addresses)

    #updates a duration (transit, walk and drive) to each Midway Participant
    venue_service = VenueService.new(addresses: addresses_coordinates, venue_lat: @venue.lat, venue_lng: @venue.lng, time_option: @midway.time_option.to_i, future_time: @midway.future_time.to_datetime.to_i)
    transit_durations = venue_service.calculate_transit
    @participants.each_with_index do |participant, index|
      participant.duration_to_midpoint = transit_durations[index]
      participant.save!
    end

    walk_durations = venue_service.calculate_walk
    @participants.each_with_index do |participant, index|
      participant.walk_to_midpoint = walk_durations[index]
      participant.save!
    end

    drive_durations = venue_service.calculate_drive
    @participants.each_with_index do |participant, index|
      participant.drive_to_midpoint = drive_durations[index]
      participant.save!
    end

    #passes the midpoint info into hash for the map to access
    midpoint = @midway.midpoint
    @midpoint_hash = Hash.new
    @midpoint_hash[:lat] = midpoint.split(",")[0]
    @midpoint_hash[:lng] = midpoint.split(",")[1]

    @markers = addresses_coordinates.map do |participant|
      {
        lat: participant[:lat],
        lng: participant[:lng]
      }
    end
  end

    private

  def midway_params
    params.require(:midway).permit(:friends, :time_option, :future_time, :venue_type, :venue)
  end

  def venue_params
    params.permit(:name, :address, :lat, :lng, :categories, :photo_url)
  end

  def convert_to_geocode(addresses)
    addresses.map! do |address|
      results = Geocoder.search(address)
      if results.nil?
        convert_to_geocode
      end
      { lat: results.first.coordinates[0], lng: results.first.coordinates[1]}
    end
  end

  def fetching_venue(venues)
    venue_hash = []

    venues.each do |venue|

      open_info = venue["opening_hours"].nil? ? "n/a" : venue["opening_hours"]["open_now"]
      photo_string = venue["photos"].nil? ? "" : venue["photos"][0]["photo_reference"]
      venue["types"].delete("point_of_interest")
      venue["types"].delete("establishment")

      venue_hash << {
      name: venue["name"],
      address: venue["vicinity"].split.map(&:capitalize).join(' '),
      categories: venue["types"],
      rating: venue["rating"],
      open_boolean: open_info,
      photo_reference: photo_string,
      lat: venue["geometry"]["location"]["lat"],
      lng: venue["geometry"]["location"]["lng"],
      }
    end

    venue_hash.each do |venue|
      if venue[:photo_reference].nil? || venue[:photo_reference] == ""
        venue[:photo] = "https://sca.frogbikes.com/secure/img/no_image_available.jpeg"
      else
        venue[:photo] = FoursquareService.new(photo_reference: venue[:photo_reference]).search_photo
      end
    end

    venue_hash
  end

end
