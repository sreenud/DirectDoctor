module ApplicationHelper
  include Pagy::Frontend

  def gmaps_script
    # add condition for conditional loading of gmaps api
    api_key = 'AIzaSyBmxDr3-x_KEHARd7d1AH-9aOpgNPKoYSI'
    tag.script(
      src: "https://maps.googleapis.com/maps/api/js?key=#{api_key}&libraries=&v=weekly",
      defer: true
    )
  end
end
