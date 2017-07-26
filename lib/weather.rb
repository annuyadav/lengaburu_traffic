class Weather
  attr_reader :name
  attr_accessor :craters_factor

  def initialize(name)
    @name = name
    @craters_factor = 1
  end

  def update_craters_percentage(percent)
    self.craters_factor += (percent.to_f/100)
  end
end