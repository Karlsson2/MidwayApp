class MidwaysController < ApplicationController

  def index
  end

  def new
    #form is here...
  end

  def choose_venue
    midpoint_service = MidpointService.new(addresses: ["Putney UK", "Shoreditch UK", "Bethnal Green UK"], arrival_time: 1606327200)
    midpoint_coordinates = midpoint_service.calculate
    @midpoint = "#{midpoint_coordinates[:lat]},#{midpoint_coordinates[:lng]}"
    # this will be where user choose the venues, after the midpoint has been displayed to them
  end

  def create
    # choose_venue

    # @midway = Midway.new
    # @midway.user = current_user
    # @midway.midpoint = @midpoint
    # @midway.venue = @venue
    # @midway.save!
  end

  # def show
  #   # this will be confirmation page
  # end

end
