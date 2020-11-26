class MidwaysController < ApplicationController

  def index
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

    #assigns the midpoint
    midpoint_service = MidpointService.new(addresses: participants_locations, time_option: time_option, future_time: future_time)
    midpoint_coordinates = midpoint_service.calculate
    @midpoint = "#{midpoint_coordinates[:lat]},#{midpoint_coordinates[:lng]}"
    @midway.midpoint = @midpoint
    @midway.save!
  end

  def edit
    
    #find the midway we are editing and gets its midpoint that was saved
    midpoint = (Midway.find(params[:id])).midpoint
    # this queries the foursquare api and saves an ARRAY of venues in @venues
    foursquare_service = FoursquareService.new(location: midpoint, radius: 200, categoryid: "4bf58dd8d48988d11b941735")
    @venues = foursquare_service.find_venues

    # save all venue lat and long into array alled markers
    @markers = @venues.map do |venue|
      {
        lat: venue["location"]["lat"],
        lng: venue["location"]["lng"]
      }
    end
  end

  # def show
  #   # this will be confirmation page
  # end

    private

  def midway_params
    params.require(:midway).permit(:friends, :time_option, :future_time)
  end

end
