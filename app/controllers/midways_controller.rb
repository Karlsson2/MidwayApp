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
    midpoint_service = MidpointService.new(addresses: ["Putney UK", "Shoreditch UK", "Bethnal Green UK"], arrival_time: 1606327200)
    midpoint_coordinates = midpoint_service.calculate
    @midpoint = "#{midpoint_coordinates[:lat]},#{midpoint_coordinates[:lng]}"

    @midway = Midway.new(midway_params)
    @midway.user = current_user
    @midway.midpoint = @midpoint

    params[:users_id].each do |user_id|
      MidwayParticipant.new(params[:user_id])
    end

    @midway.save!
  end

  def edit

    #find the midway we are editing and gets its midpoint that was saved
    midpoint = (Midway.find(params[:id])).midpoint
    # this queries the foursquare api and saves an ARRAY of venues in @venues
    foursquare_service = FoursquareService.new(location: midpoint, radius: 200, categoryid: "4bf58dd8d48988d11b941735")
    @venues = foursquare_service.find_venues
  end

  # def show
  #   # this will be confirmation page
  # end

    private

  def midway_params
  end

end
