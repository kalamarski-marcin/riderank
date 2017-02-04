module TaxiRides
  # :nodoc:
  class CreateTaxiRideService
    attr_reader :taxi_ride, :params

    def initialize(taxi_ride, distance_matrix_service, params)
      @taxi_ride = taxi_ride
      @params = params
      @distance_matrix_service = distance_matrix_service
    end

    def execute
      success = ActiveRecord::Base.transaction do
        create_start_address
        create_destination_address
        create_route
        taxi_provider
        create_taxi_ride
      end
      success
    rescue TaxiRides::DistanceMatrixError => e
      raise TaxiRides::CreateTaxiRideServiceError, e.message
    end

    private

    def taxi_provider
      @taxi_provider = TaxiProvider.find(@params[:taxi_provider_id])
    end

    def create_start_address
      @start_address = TaxiRides::AddressRepository.find_or_create(
        address: @params[:start_address]
      )
    end

    def create_destination_address
      @destination_address = TaxiRides::AddressRepository.find_or_create(
        address: @params[:destination_address]
      )
    end

    def create_route
      @route = TaxiRides::RouteRepository.find_by_addresses(
        start_address: @start_address,
        destination_address: @destination_address
      )
      if @route.blank?
        measure_distance
        @route = TaxiRides::RouteRepository.create(
          start_address: @start_address,
          destination_address: @destination_address,
          distance: @distance
        )
      end
    end

    def measure_distance
      @distance = @distance_matrix_service.execute
    end

    def create_taxi_ride
      TaxiRides::TaxiRideRepository.create(
        taxi_ride: @taxi_ride,
        route: @route,
        taxi_provider: @taxi_provider,
        price: @params[:price].to_f
      )
    end
  end
end
