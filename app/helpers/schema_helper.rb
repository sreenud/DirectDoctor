module SchemaHelper
  def srp_page_schema(doctors)
    list = []
    website_url = "https://www.findmydirectdoctor.com"

    doctors.each do |doctor|
      display_image = doctor_display_image(doctor)
      doctor_image = display_image.present? ? display_image : "#{website_url}/doctor_default.svg"

      doctor_schema = {
        "@context": "http://schema.org",
        "@type": "Physician",
        "name": doctor.name,
        "image": doctor_image,
        "url": "#{website_url}#{doctor.profile_url}",
        "currenciesAccepted": "USD",
        "priceRange": doctor.price,
        "branchOf": {
          "@type": "MedicalOrganization",
          "url": doctor.website_url,
          "name": doctor.practice_name,
        },
        "geo": {
          "@type": "GeoCoordinates",
          "latitude": doctor.lat,
          "longitude": doctor.lng,
        },
        "address": {
          "@type": "PostalAddress",
          "streetAddress": doctor.address_line_1,
          "addressLocality": doctor.city,
          "addressRegion": doctor.state,
          "postalCode": doctor.zipcode,
          "addressCountry": {
            "@type": "Country",
            "name": "USA",
          },
        },
      }
      list.push(doctor_schema)
    end
    list
  end

  def practice_style_bread_crumb_schema(practice_style)
    website_url = "https://www.findmydirectdoctor.com"
    {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement":
      [
        {
          "@type": "ListItem",
          "position": 1,
          "name": "Home",
          "item":
          {
            "@id": website_url,
          },
        },
        {
          "@type": "ListItem",
          "position": 2,
          "name": practice_style.upcase,
          "item":
          {
            "@id": "#{website_url}/#{practice_style}",
          },
        },
      ],
    }
  end

  def specialty_bread_crumb_schema(specialty)
    website_url = "https://www.findmydirectdoctor.com"
    {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement":
      [
        {
          "@type": "ListItem",
          "position": 1,
          "name": "Home",
          "item":
          {
            "@id": website_url,
          },
        },
        {
          "@type": "ListItem",
          "position": 2,
          "name": specialty&.practice_style&.upcase,
          "item":
          {
            "@id": "#{website_url}/#{specialty.practice_style}",
          },
        },
        {
          "@type": "ListItem",
          "position": 3,
          "name": specialty.name,
          "item":
          {
            "@id": "#{website_url}/#{specialty.practice_style}/#{specialty&.code&.downcase}",
          },
        },
      ],
    }
  end

  def srp_state_bread_crumb_schema(breadcrumbs)
    list = []
    website_url = "https://www.findmydirectdoctor.com"

    breadcrumbs.each_with_index do |breadcrumb, index|
      list.push(
        {
          "@type": "ListItem",
          "position": index + 1,
          "name": breadcrumb.first["name"],
          "item":
          {
            "@id": "#{website_url}#{breadcrumb.first["url"]}",
          },
        }
      )
    end

    {
      "@context": "https://schema.org",
      "@type": "BreadcrumbList",
      "itemListElement": list,
    }
  end

  def local_business_schema(params)
    website_url = "https://www.findmydirectdoctor.com"
    if params["state"].present? && params["city"].present?
      state = State.find_by_code(params["state"].upcase)
      {
        "@context": "https://schema.org",
        "@type": "LocalBusiness",
        "name": "Doctors in #{params["city"].titleize}",
        "areaServed": state.name.to_s,
        "image": "#{website_url}/logo.png",
        "aggregateRating": {
          "@type": "AggregateRating",
          "ratingValue": "4.4",
          "ratingCount": "332",
        },
      }
    end
  end
end
