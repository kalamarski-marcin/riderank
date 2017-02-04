module TaxiRides
  # :nodoc
  class GoogleMapsDistanceMatrixService < TaxiRides::DistanceMatrixService
    def execute
      google_route = Google::Maps.route(
        @start_address,
        @destination_address
      )
      @distance = (google_route.distance.value.to_f / 1_000).to_s
      @distance = BigDecimal(@distance).ceil(2).to_f
      @distance
    rescue Google::Maps::InvalidResponseException
      raise TaxiRides::DistanceMatrixError
    end
  end
end
