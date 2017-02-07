require 'rails_helper'

RSpec.describe TaxiRides::TaxiRideRepository do
  describe 'queries' do

    context '.monthly stats' do

      before :each do
        create(:taxi_ride)
        create(:taxi_ride)
        @result = TaxiRides::TaxiRideRepository::monthly_report.to_a
      end

      it 'aggregation size' do
        expect(@result.size).to eq(1)
      end

      it 'has proper sum distance' do
        expect(@result[0].distance).to eq("2000.00 km")
      end

      it 'has proper avg. distance' do
        expect(@result[0].avg_distance).to eq("1000.00 km")
      end

      it 'has proper avg. price' do
        expect(@result[0].avg_price).to eq("100.00 EUR")
      end

      it 'has proper taxis' do
        expect(@result[0].taxis).to match(/Taxi [0-9]{1,}, Taxi [0-9]{1,}/)
      end
    end
  end
end
