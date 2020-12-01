require 'rubygems'
require 'json'
require 'open-uri'

class MidpointService
  def initialize(attributes = {})
    @addresses = attributes[:addresses]
    @time_option = attributes[:time_option]
    @future_time = attributes[:future_time]
    convert_to_geocode
    @midpoint = { lat: 0, lng: 0 }
  end

  def calculate

    # find the average lat and long of all user locations (set this to variable D) - this is the first attempt at the midpoint (based purely off geographical equidistance)

    lat_sum = @addresses.map { |address| address[:lat] }.sum
    lng_sum = @addresses.map { |address| address[:lng] }.sum
    @midpoint[:lat] = lat_sum / @addresses.count
    @midpoint[:lng] = lng_sum / @addresses.count

    # make the API calls to find the distances and duration between each user location and attempted midpoint

    @condition = false
    url_time = @time_option == 1 ? "arrival_time=#{@future_time}" : "departure_time=#{@future_time}"

    address_query=""
    @addresses.each do |address|
      iaq = "|#{address[:lat]},#{address[:lng]}"
      address_query = address_query + iaq
    end
    p address_query

    candidates = []
    5.times do

      url = "https://api.distancematrix.ai/maps/api/distancematrix/json?units=imperial&origins=#{address_query}&destinations=#{@midpoint[:lat]},#{@midpoint[:lng]}&transit_mode=subway&mode=transit&#{url_time}&key=#{ENV["DISTANCE_MATRIX_KEY"]}"
      @matrix = JSON.parse(open(url).read, symbolize_names: true)

      @addresses.each_with_index do |address, index|
        address[:duration] = @matrix[:rows][index+1][:elements][0][:duration][:value]
        address[:duration_text] = @matrix[:rows][index+1][:elements][0][:duration][:text]
      end

      # determines the longest route between a user and @midpoint
      durations = @addresses.map { |address| address[:duration] }
      max_duration = durations.max
      md_index = durations.index(max_duration)

      durations_text = @addresses.map { |address| address[:duration_text] }

      # reassigns the midpoint to a new location (skewed to be closer to the user who previously would have had to travel the longest)

      avg = (durations.sum / durations.count).to_f
      percentage = avg / max_duration
      @midpoint[:lat] = lerp(@addresses[md_index][:lat], @midpoint[:lat], percentage)
      @midpoint[:lng] = lerp(@addresses[md_index][:lng], @midpoint[:lng], percentage)
      min_duration = durations.min

      # stores as candidate_duration the discrepancy between the largest/smallest travel time

      candidate_duration = (max_duration - min_duration).abs
      candidates.push([@midpoint, candidate_duration, durations_text])
    end

      # of the 5 attempts, selects the midpoint with the smallest discrepancy (candidate_duration)
      # returns the chosen midpoint

    candidate_durations = candidates.map { |candidate| candidate[1] }
    minimum_candidate_duration = candidate_durations.min
    mcd_index = candidate_durations.index(minimum_candidate_duration)
    candidate_midpoints = candidates.map { |candidate| candidate[0] }
    @midpoint = candidate_midpoints[mcd_index]
    p candidates
    p candidate_durations
    p @midpoint

    candidate_durations_text = candidates.map { |candidate| candidate[2] }
    @durations_text = candidate_durations_text[mcd_index]
    # p "Durations: #{@durations_text}"
    return [@midpoint, @durations_text]
  end

  private

  def lerp(v0, v1, t)
    return (1-t) * v0 + t * v1
  end

  def convert_to_geocode
    @addresses.map! do |address|
      results = Geocoder.search(address)
      if results.nil?
        convert_to_geocode
      end
      { lat: results.first.coordinates[0], lng: results.first.coordinates[1], duration: 0 }
    end
  end
end
