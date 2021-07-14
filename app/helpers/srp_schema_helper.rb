module SrpSchemaHelper
  def generate_schema(doctors)
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
end
