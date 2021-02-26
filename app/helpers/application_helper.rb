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

  def speciality_name(params)
    if params[:speciality_slug].present?
      params[:speciality_slug]&.titleize
    elsif params[:speciality_name].present?
      params[:speciality_name]
    else
      Speciality.find_by_code(params[:speciality])&.name
    end
  end

  def search_page_h1_tag(location_string, params)
    place = if location_string.present?
      location_string
    else
      params[:place].titleize
    end

    h1_tag_text = "Concierge Doctors/Direct Primary Care Physicians in #{place}"

    if params[:style].present?
      h1_tag_text = if params[:style] == "direct-primary-care"
        "Direct Primary Care Physicians in #{place}"
      else
        "Concierge Doctors in #{place}"
      end
    end

    if params[:speciality_slug].present?
      h1_tag_text = "#{params[:speciality_slug].titleize} in #{place}"
    end

    if params[:location].present?
      h1_tag_text = "#{params[:speciality_slug].titleize} in #{params[:location].titleize}, #{place}"
    end

    if params[:speciality].present?
      speciality = Speciality.find_by_code(params["speciality"])

      h1_tag_text = "#{speciality&.name} in #{params[:place]}"
    end

    h1_tag_text
  end
end
