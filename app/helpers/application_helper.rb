module ApplicationHelper
  include Pagy::Frontend

  def gmaps_script
    return unless defined?(@load_gmaps) && @load_gmaps

    api_key = 'AIzaSyBmxDr3-x_KEHARd7d1AH-9aOpgNPKoYSI'
    call = 'initMap'
    tag.script(
      src: "https://maps.googleapis.com/maps/api/js?key=#{api_key}&callback=#{call}&libraries=&v=weekly",
      defer: true
    )
  end
end
