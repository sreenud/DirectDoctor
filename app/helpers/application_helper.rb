module ApplicationHelper
  include Pagy::Frontend

  def gmaps_script
    # add condition for conditional loading of gmaps api
    api_key = 'AIzaSyBmxDr3-x_KEHARd7d1AH-9aOpgNPKoYSI'
    (tag.script(
      src: "https://maps.googleapis.com/maps/api/js?key=#{api_key}&libraries=&v=weekly",
      defer: true
    ) + tag.script(
      src: '//cdnjs.cloudflare.com/ajax/libs/gmaps.js/0.4.25/gmaps.min.js',
      integrity: 'sha512-gauu0VKZq9ry8hOZHgNpcB2ogbSDojs+XLDItpOLY0IyA+KigeuT/suwSdPgfU/TGYLAn4Nan4OeaCa/UPr70Q==',
      crossorigin: 'anonymous'
    )).html_safe
  end

  def current_location
    @current_location
  end

  def format_currency(amount, precision = 0)
    number_to_currency(amount, precision: precision, unit: "")
  end
end
