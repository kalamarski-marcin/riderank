require 'rails_helper'

RSpec.describe TaxiRides::CreateTaxiRideService do
  describe 'execute' do
    context 'when returns true' do
      it 'saves taxi ride' do
        taxi_ride = TaxiRide.new
        taxi_provider = create(:taxi_provider)
        distance_matrix_service = double()
        params = {
          start_address: '1,2,3',
          destination_address: '4,5,6',
          taxi_provider_id: taxi_provider.id,
          price: 100
        }
        create_taxi_ride_service = TaxiRides::CreateTaxiRideService.new(taxi_ride, distance_matrix_service, params)
        allow(distance_matrix_service).to receive(:execute) { 10 }
        expect { create_taxi_ride_service.execute }.to change(TaxiRide, :count)
      end
    end

    context 'when distance_matrix_service raise TaxiRides::DistanceMatrixError' do
      it 'raises TaxiRides::CreateTaxiRideServiceError' do
        e = TaxiRides::DistanceMatrixError.new
        taxi_ride = double()
        params = {}
        distance_matrix_service = double()
        allow(distance_matrix_service).to receive(:execute){ raise e }
        create_taxi_ride_service = TaxiRides::CreateTaxiRideService.new(taxi_ride, distance_matrix_service, params)
        expect { create_taxi_ride_service.execute }.to raise_error
      end
    end
  end
end
