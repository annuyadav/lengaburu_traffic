require 'spec_helper'

RSpec.describe Orbit do

  describe 'initialize' do
    context 'initiates a new object of orbit with valid attributes' do
      subject do
        Orbit.new('Orbit1', 8, 10)
      end

      it 'initiates orbit object' do
        expect(subject).to be_an_instance_of Orbit
      end

      it 'should return orbit name' do
        expect(subject.name).to eq 'Orbit1'
      end

      it 'should return orbit distance' do
        expect(subject.distance).to eq 8
      end

      it 'should return number of craters in orbit' do
        expect(subject.number_of_craters).to eq 10
      end
    end

    context 'when valid attributes are not provided' do
      subject do
        Orbit.new('Orbit1')
      end

      it 'should raise an ArgumentError error' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end
  end

  describe 'update_weather_condition' do
    let(:orbit1) { Orbit.new('Orbit1', 8, 10) }
    let(:sunny_weather) { Weather.new('Sunny') }
    let(:windy_weather) { Weather.new('Windy') }

    before do
      sunny_weather.update_craters_percentage(-10)
    end

    it 'updates the number of craters for orbit when Sunny weather' do
      expect{orbit1.update_weather_condition(sunny_weather)}.to change {orbit1.number_of_craters}.from(10).to(9)
    end

    it 'will not update craters for windy weather' do
      _craters_before = orbit1.number_of_craters
      expect(orbit1.update_weather_condition(windy_weather)).to eq _craters_before
    end
  end

  describe 'update_traffic_speed' do
    let(:orbit1) { Orbit.new('Orbit1', 8, 10) }

    it 'updates the traffic speed of orbit' do
      orbit1.traffic_speed = 18
      expect(orbit1.traffic_speed).to eq 18
    end
  end
end