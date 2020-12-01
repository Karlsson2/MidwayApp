module MidwayHelper
  def venue_color(string)
    if string == "Open now"
      "green"
    elsif string == "Closed now"
      "red"
    end
  end
end
