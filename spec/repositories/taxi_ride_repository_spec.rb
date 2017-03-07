require 'rails_helper'

RSpec.describe TaxiRides::TaxiRideRepository do
  describe 'queries' do

    context '.save' do
      it 'returns true' do
        route = create(:route)
        taxi_provider = create(:taxi_provider)
        user = create(:user)
        price = 100
        taxi_ride = TaxiRide.new

        expect(
          TaxiRides::TaxiRideRepository.save(
            taxi_ride: taxi_ride,
            route: route,
            taxi_provider: taxi_provider,
            price: price,
            user: user
          )
        ).to be_truthy
      end
    end

    context '.monthly_report' do

      before :each do
        create(:taxi_ride)
        create(:taxi_ride)
        @results = TaxiRides::TaxiRideRepository::monthly_report.to_a
      end

      it 'counts results' do
        expect(@results.size).to eq(1)
      end

      it 'has proper sum distance' do
        expect(@results[0].distance).to eq("2000.00 km")
      end

      it 'has proper avg. distance' do
        expect(@results[0].avg_distance).to eq("1000.00 km")
      end

      it 'has proper avg. price' do
        expect(@results[0].avg_price).to eq("100.00 EUR")
      end

      it 'has proper taxis string' do
        expect(@results[0].taxis).to match(/Taxi [0-9]{1,}, Taxi [0-9]{1,}/)
      end
    end

    context '.weekly_stats' do

      before :each do
        create(:taxi_ride)
        create(:taxi_ride)
        @result = TaxiRides::TaxiRideRepository.weekly_stats
      end

      it 'has proper sum distance' do
        expect(@result.sum_distance).to eq("2000.00 km")
      end

      it 'has proper sum price' do
        expect(@result.sum_price).to eq("200.00 EUR")
      end
    end

    context '.daily_stats' do

      before :each do
        create(:taxi_ride)
        create(:taxi_ride)
        @result = TaxiRides::TaxiRideRepository.daily_stats
      end

      it 'has proper sum distance' do
        expect(@result.sum_distance).to eq("2000.00 km")
      end

      it 'has proper sum price' do
        expect(@result.sum_price).to eq("200.00 EUR")
      end
    end
  end
end
