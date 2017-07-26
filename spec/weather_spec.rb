require 'spec_helper'

RSpec.describe Weather do

  let(:names) { %w(Sunny Rainy Windy) }

  describe 'initialize' do
    it 'initiates Weather class object' do
      names.each do |name|
        weather = Weather.new(name)
        expect(weather).to be_an_instance_of Weather
        expect(weather.name).to eq name
        expect(weather.craters_factor).to eq 1
      end
    end
  end

  describe 'update_craters_percentage' do
    let(:sunny){ Weather.new('Sunny') }
    let(:windy){ Weather.new('Windy') }

    it 'update craters percentage of weather' do
      sunny.update_craters_percentage(-10)
      windy.update_craters_percentage(20)
      expect(sunny.craters_factor).to eq 0.9
      expect(windy.craters_factor).to eq 1.2
    end
  end
end
