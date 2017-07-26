require_relative './weather'

class Vehicle
  attr_reader :name, :crater_time, :priority
  attr_accessor :speed, :feasible_weathers

  def initialize(name, speed, crater_time, priority, feasible_weathers=[])
    @name = name
    @speed = speed
    @crater_time = crater_time / 60.0
    @priority = priority
    @feasible_weathers = feasible_weathers
  end

  def allowed_weathers(weathers)
    self.feasible_weathers = weathers unless weathers.nil? || weathers.empty?
  end

  def max_speed (orbit)
    speed > orbit.traffic_speed ? orbit.traffic_speed : speed
  end

  def trip_time_evaluation (orbit)
    (orbit.distance / max_speed(orbit).to_f + time_delay_due_to_craters(orbit)).round 2
  end

  def time_delay_due_to_craters (orbit)
    crater_time * orbit.number_of_craters
  end
end