module BreadCrumbHelper
  def search_page_bread_crumb(params)
    bread_crumbs = []
    bread_crumbs << [
      "name" => "Home",
      "url" => "/",
      "type" => "home",
    ]

    if params["place"].present?
      bread_crumbs << [
        "name" => params["place"].titleize,
        "type" => "place",
      ]
    end

    if params["style"].present?
      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "place"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/#{params["place"]}"
        end
      end

      bread_crumbs << [
        "name" => params["style"].titleize,
        "type" => "style",
      ]
    end

    if params["speciality_slug"].present?
      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "style"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/#{params["place"]}/#{params["style"]}"
        end
      end

      bread_crumbs << [
        "name" => params["speciality_slug"].titleize,
        "type" => "speciality",
      ]
    end

    if params["location"].present?
      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "speciality"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/#{params["place"]}/#{params["style"]}/#{params["speciality_slug"]}"
        end
      end

      bread_crumbs << [
        "name" => "#{params["location"].titleize}, #{params["place"].titleize}",
        "type" => "location",
      ]
    end

    if params["speciality"].present?
      speciality = Speciality.find_by_code(params["speciality"])

      bread_crumbs.each do |bread_crumb|
        next unless bread_crumb&.first["type"] == "place"
        bread_crumb&.first.tap do |bread|
          bread["url"] = "/search-map?near=#{params["near"]}&place=#{params["place"]}"
        end
      end

      bread_crumbs << [
        "name" => speciality&.name,
        "type" => "speciality",
      ]
    end

    bread_crumbs
  end

  def srp_page_bread_crumb(params)
    request_path = request.path

    bread_crumbs = []
    bread_crumbs << [
      "name" => "Home",
      "url" => "/",
      "type" => "home",
      "code" => "",
      "enable_link" => true,
    ]

    if params["state"].present? && request_path == "/all/doctors/#{params["state"]}"
      state = State.find_by_code(params["state"].upcase)
      bread_crumbs << [
        "name" => "#{state.name}, USA",
        "type" => "state",
        "code" => params["state"],
        "url" => "/all/doctors/#{params["state"]}",
        "enable_link" => false,
      ]
    end

    if params["state"].present? && params["city"].present? &&
      request_path == "/all/doctors/#{params["state"]}/#{params["city"]}"

      state = State.find_by_code(params["state"].upcase)

      bread_crumbs << [
        "name" => state.name.to_s,
        "type" => "state",
        "code" => params["state"],
        "url" => "/all/doctors/#{params["state"]}",
        "enable_link" => true,
      ]
      bread_crumbs << [
        "name" => params["city"].titleize.to_s,
        "type" => "city",
        "code" => params["city"],
        "url" => "/all/doctors/#{params["state"]}/#{params["city"]}",
        "enable_link" => false,
      ]
    end
  end
end
