module SrpSchemaHelper
  def generate_schema(doctors)
    list = []

    doctors.each do |doctor|
      list.push(
       "@context": "http://health-lifesci.schema.org",
        "@type" => "Physician",
        "name" => doctor.name,
        "image": doctor_display_image(doctor),
        "url": "https://www.findmydirectdoctor.com#{doctor.profile_url}",
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
        }
      )
    end
    list
  end
end
