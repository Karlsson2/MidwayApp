require 'rubygems'
require 'json'
require 'open-uri'

class MidpointService
  def initialize(attributes = {})
    @addresses = attributes[:addresses]
    @time_option = attributes[:time_option]
    @future_datetime = attributes[:future_datetime]
    convert_to_geocode
    @midpoint = { lat: 0, lng: 0 }
  end

  def calculate_efficient

    # find the average lat and long of all user locations (set this to variable D) - this is the first attempt at the midpoint (based purely off geographical equidistance)

    lat_sum = @addresses.map { |address| address[:lat] }.sum
    lng_sum = @addresses.map { |address| address[:lng] }.sum
    @midpoint[:lat] = lat_sum / @addresses.count
    @midpoint[:lng] = lng_sum / @addresses.count

    # make the API calls to find the distances and duration between each user location and attempted midpoint

    @condition = false
    url_time = @time_option == 1 ? "arrival_time=#{@future_datetime}" : "departure_time=#{@future_datetime}"

    address_query=""
    @addresses.each do |address|
      iaq = "|#{address[:lat]},#{address[:lng]}"
      address_query = address_query + iaq
    end
    p address_query

    candidates = []
    user_candidates = []
    3.times do

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
      min_duration = durations.min

      durations_text = @addresses.map { |address| address[:duration_text] }

      # reassigns the midpoint to a new location (skewed to be closer to the user who previously would have had to travel the longest)

      avg = (durations.sum / durations.count).to_f
      percentage = avg / max_duration
      @midpoint[:lat] = lerp(@addresses[md_index][:lat], @midpoint[:lat], percentage)
      @midpoint[:lng] = lerp(@addresses[md_index][:lng], @midpoint[:lng], percentage)

      # stores as candidate_duration the discrepancy between the largest/smallest travel time

      candidate_duration = (max_duration - min_duration).abs
      candidates.push([@midpoint, candidate_duration, durations_text, avg])
    end

      # also puts as candidate midpoints the home locations of each of the users

    @addresses.each do |address|
      url = "https://api.distancematrix.ai/maps/api/distancematrix/json?units=imperial&origins=#{address_query}&destinations=#{address[:lat]},#{address[:lng]}&transit_mode=subway&mode=transit&#{url_time}&key=#{ENV["DISTANCE_MATRIX_KEY"]}"

      @matrix = JSON.parse(open(url).read, symbolize_names: true)

      @addresses.each_with_index do |address, index|
        address[:duration] = @matrix[:rows][index+1][:elements][0][:duration][:value]
        address[:duration_text] = @matrix[:rows][index+1][:elements][0][:duration][:text]
      end

      # determines the longest route between a user and @midpoint
      durations = @addresses.map { |address| address[:duration] }
      max_duration = durations.max
      md_index = durations.index(max_duration)
      min_duration = durations.min
      durations_text = @addresses.map { |address| address[:duration_text] }
      avg = (durations.sum / durations.count).to_f

      candidate_duration = (max_duration - min_duration).abs
      user_candidates.push([address, candidate_duration, durations_text, avg])
    end

      # of all the 5 attempts, selects the midpoint with the smallest discrepancy (candidate_duration)
      # returns the chosen midpoint

    candidate_durations = candidates.map { |candidate| candidate[1] }
    minimum_candidate_duration = candidate_durations.min
    mcd_index = candidate_durations.index(minimum_candidate_duration)
    candidate_midpoints = candidates.map { |candidate| candidate[0] }
    @midpoint = candidate_midpoints[mcd_index]
    p "Candidates:"
    p candidates
    p "_________"
    # p candidate_durations
    p "User Candidates"
    p user_candidates
    p "_________"
    p @midpoint

      # then it checks that this midpoint does not have an average duration greater than any of the user locations
      # if it does it reassigns

    candidate_averages = candidates.map { |candidate| candidate[3] }
    midpoint_average = candidate_averages[mcd_index]
    p midpoint_average
    user_candidate_midpoints = user_candidates.map { |candidate| candidate[0] }
    user_candidate_averages = user_candidates.map { |candidate| candidate[3] }
    min_user_candidate_average = user_candidate_averages.min
    p min_user_candidate_average
    mucd_index = user_candidate_averages.index(min_user_candidate_average)
    if midpoint_average > user_candidate_averages.min
      @midpoint = user_candidate_midpoints[mucd_index]
      user_candidate_durations_text = user_candidates.map { |candidate| candidate[2] }
      @durations_text = user_candidate_durations_text[mucd_index]
    else
      candidate_durations_text = candidates.map { |candidate| candidate[2] }
      @durations_text = candidate_durations_text[mcd_index]
    end
    p @midpoint

    # p "Durations: #{@durations_text}"
    return [@midpoint, @durations_text]
  end

  def calculate_equal

    # find the average lat and long of all user locations (set this to variable D) - this is the first attempt at the midpoint (based purely off geographical equidistance)

    lat_sum = @addresses.map { |address| address[:lat] }.sum
    lng_sum = @addresses.map { |address| address[:lng] }.sum
    @midpoint[:lat] = lat_sum / @addresses.count
    @midpoint[:lng] = lng_sum / @addresses.count

    # make the API calls to find the distances and duration between each user location and attempted midpoint

    @condition = false
    url_time = @time_option == 1 ? "arrival_time=#{@future_datetime}" : "departure_time=#{@future_datetime}"

    address_query=""
    @addresses.each do |address|
      iaq = "|#{address[:lat]},#{address[:lng]}"
      address_query = address_query + iaq
    end
    p address_query

    candidates = []
    user_candidates = []
    3.times do

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
      min_duration = durations.min

      durations_text = @addresses.map { |address| address[:duration_text] }

      # reassigns the midpoint to a new location (skewed to be closer to the user who previously would have had to travel the longest)

      avg = (durations.sum / durations.count).to_f
      percentage = avg / max_duration
      @midpoint[:lat] = lerp(@addresses[md_index][:lat], @midpoint[:lat], percentage)
      @midpoint[:lng] = lerp(@addresses[md_index][:lng], @midpoint[:lng], percentage)

      # stores as candidate_duration the discrepancy between the largest/smallest travel time

      candidate_duration = (max_duration - min_duration).abs
      candidates.push([@midpoint, candidate_duration, durations_text, avg])
    end

      # of all the 5 attempts, selects the midpoint with the smallest discrepancy (candidate_duration)
      # returns the chosen midpoint

    candidate_durations = candidates.map { |candidate| candidate[1] }
    minimum_candidate_duration = candidate_durations.min
    mcd_index = candidate_durations.index(minimum_candidate_duration)
    candidate_midpoints = candidates.map { |candidate| candidate[0] }
    @midpoint = candidate_midpoints[mcd_index]

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
        results = Geocoder.search(address)
      end
      { lat: results.first.coordinates[0], lng: results.first.coordinates[1], duration: 0 }
    end
  end
end
