require 'spec_helper'

RSpec.describe Vehicle do

  let(:sunny_weather) { Weather.new('Sunny') }
  let(:windy_weather) { Weather.new('Windy') }
  let(:rainy_weather) { Weather.new('Rainy') }

  before do
    sunny_weather.update_craters_percentage(-10)
    rainy_weather.update_craters_percentage(20)
  end

  describe 'initialize' do

    context 'initiates a new bike of vehicle with valid attributes' do
      subject do
        Vehicle.new 'Bike', 10, 2, 1, [sunny_weather, windy_weather]
      end

      it 'initiates Vehicle object' do
        expect(subject).to be_an_instance_of Vehicle
      end

      it 'should return Vehicle name' do
        expect(subject.name).to eq 'Bike'
      end

      it 'should return Vehicle speed' do
        expect(subject.speed).to eq 10
      end

      it 'should return time taken to cross a craters by Vehicle' do
        expect(subject.crater_time).to eq 2/60.0
      end

      it 'should return priority of Vehicle' do
        expect(subject.priority).to eq 1
      end

      it 'should return all feasible weathers of Vehicle' do
        expect(subject.feasible_weathers).to eq [sunny_weather, windy_weather]
      end

    end

    context 'when valid attributes are not provided' do
      subject do
        Vehicle.new('Bike')
      end

      it 'should raise an ArgumentError error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'allowed_weathers' do
    let(:tuktuk) { Vehicle.new 'tuktuk', 12, 1, 2 }

    subject do
      tuktuk.allowed_weathers([sunny_weather])
    end

    it 'updates the feasible weathers for the vehicle' do
      subject
      expect(tuktuk.feasible_weathers).to include sunny_weather
    end

    it 'will not update feasible weathers for vehicle if invalid param is provided' do
      _previous_wethers = tuktuk.feasible_weathers
      tuktuk.allowed_weathers([])
      expect(tuktuk.feasible_weathers).to eq (_previous_wethers)
    end
  end


  describe 'max_speed' do
    let(:tuktuk) { Vehicle.new 'tuktuk', 12, 1, 2 }
    let(:car) { Vehicle.new 'car', 15, 1, 3 }
    let(:orbit1) { Orbit.new('Orbit1', 8, 10) }

    context 'when orbit traffic speed is less than Vehicle speed' do
      it 'returns its max speed as traffic speed' do
        orbit1.update_traffic_speed(10)
        expect(tuktuk.max_speed(orbit1)).to eq 10
        expect(car.max_speed(orbit1)).to eq 10
      end
    end

    context 'when orbit traffic speed is more than Vehicle speed' do
      it 'returns its max speed as Vehicle speed' do
        orbit1.update_traffic_speed(20)
        expect(tuktuk.max_speed(orbit1)).to eq 12
        expect(car.max_speed(orbit1)).to eq 15
      end
    end
  end

  describe 'trip_time_evaluation' do
    let(:tuktuk) { Vehicle.new 'tuktuk', 12, 1, 2, [sunny_weather] }
    let(:car) { Vehicle.new 'car', 15, 2, 3, [sunny_weather] }
    let(:orbit1) { Orbit.new('Orbit1', 8, 10) }

    before do
      orbit1.update_weather_condition(sunny_weather)
      orbit1.update_traffic_speed(10)
    end

    it 'return the total time taken for the orbit with provided weather' do
      expect(tuktuk.trip_time_evaluation orbit1).to eq 0.95
      expect(car.trip_time_evaluation orbit1).to eq 1.1
    end
  end

  describe 'time_delay_due_to_craters' do
    let(:tuktuk) { Vehicle.new 'tuktuk', 12, 1, 2, [sunny_weather] }
    let(:car) { Vehicle.new 'car', 15, 2, 3, [sunny_weather] }
    let(:orbit1) { Orbit.new('Orbit1', 8, 10) }

    before do
      orbit1.update_weather_condition(sunny_weather)
    end

    it 'return the total time taken to cross craters in orbit' do
      expect(tuktuk.time_delay_due_to_craters orbit1).to eq 0.15
      expect(car.time_delay_due_to_craters orbit1).to eq 0.3
    end
  end
end