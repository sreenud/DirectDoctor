namespace :state do
  desc "Update state slug"
  task update_slug: :environment do
    @states = State.pluck(:id, :name)
    @states.each do |state|
      @state = State.find(state.first)
      @state.slug = state.last.parameterize
      @state.save
    end
    puts "States and cities import is completed"
  end

  desc "Update lat and lng data"
  task update_lat_lng: :environment do
    data = {
      "AK" => {"lat" => "63.588753", "lng" => "-154.493062"},
      "AL" => {"lat" => "32.318231", "lng" => "-86.902298"},
      "AR" => {"lat" => "35.20105", "lng" => "-91.831833"},
      "AZ"=> {"lat" => "34.048928", "lng" => "-111.093731"},
      "CA"=> {"lat" => "36.778261", "lng" => "-119.417932"},
      "CO"=> {"lat" => "39.550051", "lng" => "-105.782067"},
      "CT"=> {"lat" => "41.603221", "lng" => "-73.087749"},
      "DC"=> {"lat" => "38.905985", "lng" => "-77.033418"},
      "DE"=> {"lat" => "38.910832", "lng" => "-75.52767"},
      "FL"=> {"lat" => "27.664827", "lng" => "-81.515754"},
      "GA"=> {"lat" => "32.157435", "lng" => "-82.907123"},
      "HI"=> {"lat" => "19.898682", "lng" => "-155.665857"},
      "IA"=> {"lat" => "41.878003", "lng" => "-93.097702"},
      "ID"=> {"lat" => "44.068202", "lng" => "-114.742041"},
      "IL"=> {"lat" => "40.633125", "lng" => "-89.398528"},
      "IN"=> {"lat" => "40.551217", "lng" => "-85.602364"},
      "KS"=> {"lat" => "39.011902", "lng" => "-98.484246"},
      "KY"=> {"lat" => "37.839333", "lng" => "-84.270018"},
      "LA"=> {"lat" => "31.244823", "lng" => "-92.145024"},
      "MA"=> {"lat" => "42.407211", "lng" => "-71.382437"},
      "MD"=> {"lat" => "39.045755", "lng" => "-76.641271"},
      "ME"=> {"lat" => "45.253783", "lng" => "-69.445469"},
      "MI"=> {"lat" => "44.314844", "lng" => "-85.602364"},
      "MN"=> {"lat" => "46.729553", "lng" => "-94.6859"},
      "MO"=> {"lat" => "37.964253", "lng" => "-91.831833"},
      "MS"=> {"lat" => "32.354668", "lng" => "-89.398528"},
      "MT"=> {"lat" => "46.879682", "lng" => "-110.362566"},
      "NC"=> {"lat" => "35.759573", "lng" => "-79.0193"},
      "ND"=> {"lat" => "47.551493", "lng" => "-101.002012"},
      "NE"=> {"lat" => "41.492537", "lng" => "-99.901813"},
      "NH"=> {"lat" => "43.193852", "lng" => "-71.572395"},
      "NJ"=> {"lat" => "40.058324", "lng" => "-74.405661"},
      "NM"=> {"lat" => "34.97273", "lng" => "-105.032363"},
      "NV"=> {"lat" => "38.80261", "lng" => "-116.419389"},
      "NY"=> {"lat" => "43.299428", "lng" => "-74.217933"},
      "OH"=> {"lat" => "40.417287", "lng" => "-82.907123"},
      "OK"=> {"lat" => "35.007752", "lng" => "-97.092877"},
      "OR"=> {"lat" => "43.804133", "lng" => "-120.554201"},
      "PA"=> {"lat" => "41.203322", "lng" => "-77.194525"},
      "PR"=> {"lat" => "18.220833", "lng" => "-66.590149"},
      "RI"=> {"lat" => "41.580095", "lng" => "-71.477429"},
      "SC"=> {"lat" => "33.836081", "lng" => "-81.163725"},
      "SD"=> {"lat" => "43.969515", "lng" => "-99.901813"},
      "TN"=> {"lat" => "35.517491", "lng" => "-86.580447"},
      "TX"=> {"lat" => "31.968599", "lng" => "-99.901813"},
      "UT"=> {"lat" => "39.32098", "lng" => "-111.093731"},
      "VA"=> {"lat" => "37.431573", "lng" => "-78.656894"},
      "VT"=> {"lat" => "44.558803", "lng" => "-72.577841"},
      "WA"=> {"lat" => "47.751074", "lng" => "-120.740139"},
      "WI"=> {"lat" => "43.78444	", "lng" => "-88.787868"},
      "WV"=> {"lat" => "38.597626", "lng" => "-80.454903"},
      "WY"=> {"lat" => "43.075968", "lng" => "-107.290284"},
    }

    states = State.all
    states.each do |state|
      state_obj = State.find_by_code(state.code)
      state_obj.lat = data[state_obj.code]["lat"]
      state_obj.lng = data[state_obj.code]["lng"]

      state_obj.save!
      puts "#{state.code} - lat and lng is updated"
    end
  end

  desc "Create New State"
  task create: :environment do
    name = ENV["name"]
    code = ENV["code"]

    State.create(
      name: name,
      code: code,
      status: 'active',
    )

  end
end
