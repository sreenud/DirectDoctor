namespace :location do
  desc "Import location"
  task import: :environment do
    cities = CSV.open(Rails.public_path.join('us-cities.csv'), headers: :first_row).map(&:to_h)

    cities.each do |city|
      state = State.find_by_code(city['state_code'])
      unless state.present?
        state = State.create(
          name: city['state'],
          code: city['state_code'],
        )
      end

      Location.create(
        state_id: state.id,
        name: city['name'],
        county: city['county'],
        state_code: city['state_code'],
        state: city['state'],
        zip_codes: city['zip_codes'],
        location_type: city['type'],
        latitude: city['latitude'],
        longitude: city['longitude'],
        area_code: city['area_code'],
        population: city['population'],
        households: city['households'],
        median_income: city['median_income'],
        land_area: city['land_area'],
        water_area: city['water_area'],
        time_zone: city['time_zone'],
      )
    end

    puts "States and cities import is completed"
  end
end
