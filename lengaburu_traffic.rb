module LengaburuTraffic
  @vehicle_orbit_pairs = Hash.new() {|hash, key| hash[key] = [] }

  def update_available_vehicles(available_vehicles, weather)
    available_vehicles.select!{|vehicle| vehicle.feasible_weathers.include?(weather) }
  end

  def update_orbit(orbits_list, orbit_data, weather)
    _orbit_name = orbit_data.first
    _orbit_traffic_speed = orbit_data[-2].to_i

    orbit = orbits_list.find{|orbit| orbit.name == _orbit_name }

    orbit.update_traffic_speed (_orbit_traffic_speed)
    orbit.update_weather_condition (weather)
  end

  def self.evaluate(available_vehicles, available_orbits)
    save_time_for_vehicle_and_orbit(available_vehicles, available_orbits)
    _fastest_time = calculate_fastest_time
    calculate_preferred_pair(_fastest_time)
    print_result(_fastest_time)
  end

  private

  def self.save_time_for_vehicle_and_orbit(available_vehicles, available_orbits)
    @vehicle_orbit_pairs.clear

    available_orbits.each{ |orbit|
      available_vehicles.each{ |vehicle|
        @vehicle_orbit_pairs[vehicle.trip_time_evaluation(orbit)] << ({orbit: orbit, vehicle: vehicle})
      }
    }
  end

  def self.calculate_fastest_time
    @vehicle_orbit_pairs.keys.min
  end

  def self.calculate_preferred_pair(lowest_time)
    if @vehicle_orbit_pairs[lowest_time].size > 1
      @vehicle_orbit_pairs[lowest_time].sort_by!{|pair| pair[:vehicle].priority }
    end
    @vehicle_orbit_pairs[lowest_time] = @vehicle_orbit_pairs[lowest_time].first
  end

  def self.print_result(time)
    _orbit = @vehicle_orbit_pairs[time][:orbit]
    _vehicle = @vehicle_orbit_pairs[time][:vehicle]
    puts "Vehicle #{_vehicle.name} on #{_orbit.name} , ETA: #{time} hours approximately."
  end
end


