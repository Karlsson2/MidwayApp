class VenueService
  def initialize(attributes = {})
    @addresses = attributes[:addresses]
    @venue_lat = attributes[:venue_lat]
    @venue_lng = attributes[:venue_lng]
    @time_option = attributes[:time_option]
    @future_time = attributes[:future_time]
  end

    def calculate
      @condition = false
      url_time = @time_option == 1 ? "arrival_time=#{@future_time}" : "departure_time=#{@future_time}"

      address_query=""
      @addresses.each do |address|
        iaq = "|#{address[:lat]},#{address[:lng]}"
        address_query = address_query + iaq
      end

      url = "https://api.distancematrix.ai/maps/api/distancematrix/json?units=imperial&origins=#{address_query}&destinations=#{@venue_lat},#{@venue_lng}&transit_mode=subway&mode=transit&#{url_time}&key=MaFhxiW105Z4AkS6w8q3oRyjvMIhU"
      @matrix = JSON.parse(open(url).read, symbolize_names: true)

      @addresses.each_with_index do |address, index|
        address[:duration] = @matrix[:rows][index+1][:elements][0][:duration][:text]
      end
      @durations_array = @addresses.map { |address| address[:duration] }
    end
end
