class Orbit
  attr_reader :name, :distance
  attr_accessor :number_of_craters, :traffic_speed

  def initialize(name, distance, number_of_craters)
    @name = name
    @distance = distance
    @number_of_craters = number_of_craters
  end

  def update_weather_condition(weather)
    self.number_of_craters *= weather.craters_factor
  end

  def update_traffic_speed(orbit_traffic_speed)
    self.traffic_speed = orbit_traffic_speed
  end
end