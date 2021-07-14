module SrpSchemaHelper
  def generate_schema(doctors)
    list = []

    doctors.each do |doctor|

      doctor_schema = {
       "@context": "http://schema.org",
        "@type": "Physician",
        "name": doctor.name,
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
      }
      doctor_schema["image"] = doctor_display_image(doctor) if doctor_display_image(doctor).present?
      list.push(doctor_schema)
    end
    list
  end
end
