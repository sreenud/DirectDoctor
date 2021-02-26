module BreadCrumbHelper
  def search_page_bread_crumb(_location_string, params)
    bread_crumbs = []
    bread_crumbs << [
      "name" => "Home",
      "url" => "/",
      "type" => "home",
    ]

    if params["place"].present?
      bread_crumbs << [
        "name" => params["place"].titleize,
        "type" => 'place',
      ]
    end

    if params["style"].present?
      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "place"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/#{params['place']}"
        end
      end

      bread_crumbs << [
        "name" => params["style"].titleize,
        "type" => 'style',
      ]
    end

    if params["speciality_slug"].present?
      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "style"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/#{params['place']}/#{params['style']}"
        end
      end

      bread_crumbs << [
        "name" => params["speciality_slug"].titleize,
        "type" => 'speciality',
      ]
    end

    if params["location"].present?
      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "speciality"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/#{params['place']}/#{params['style']}/#{params['speciality_slug']}"
        end
      end

      bread_crumbs << [
        "name" => "#{params['location'].titleize}, #{params['place'].titleize}",
        "type" => 'location',
      ]
    end

    bread_crumbs
  end
end
