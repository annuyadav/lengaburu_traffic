Dir["./lib/**/*.rb"].each {|klass| require klass }

require_relative './file_parser'
require_relative './lengaburu_traffic'

class Main
  extend LengaburuTraffic

  @weathers = []
  @vehicles_list = []
  @orbits_list = []

  def self.calculate_route
    file_parser = FileParser.new(ARGV[0] || 'input_data.txt')
    input_data      = file_parser.inputs

    self.create_all_weathers

    until input_data.empty?
      self.create_all_vehicles(*@weathers)
      self.create_all_orbits

      weather_name = input_data.shift.split(' ').last
      present_weather = @weathers.find{|weather| weather.name == weather_name }


      update_available_vehicles(@vehicles_list, present_weather)

      @orbits_list.size.times{ update_orbit(@orbits_list, input_data.shift.split(' '), present_weather) }

      LengaburuTraffic.evaluate(@vehicles_list, @orbits_list)
    end
  end

  def self.create_all_weathers
    _weathers = [['Sunny', -10], ['Rainy', 20], ['Windy', 0]]

    _weathers.each do |_weather_array|
      name, craters_change_percentage =  _weather_array[0,2]
      _weather = Weather.new(name)
      _weather.update_craters_percentage(craters_change_percentage)

      @weathers << _weather
    end
  end

  def self.create_all_vehicles(sunny, rainy, windy)
    @vehicles_list.clear
    _vehicles_data = [['Bike', 10, 2, 1, [sunny, windy]],
                      ['TukTuk', 12, 1, 2, [sunny, rainy]],
                      ['SuperCar', 20, 3, 3, [sunny, rainy, windy]]
    ]

    _vehicles_data.each do |_vehicles_array|
      @vehicles_list << Vehicle.new(*_vehicles_array)
    end
  end

  def self.create_all_orbits
    @orbits_list.clear

    _orbit_data = [['Orbit1', 18, 20], ['Orbit2', 20, 10]]

    _orbit_data.each do |meta|
      @orbits_list << Orbit.new(*meta)
    end
  end
end

Main.calculate_route