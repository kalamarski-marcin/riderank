module TaxiRides
  # :nodoc:
  class DistanceMatrixService
    attr_reader :start_address, :destination_address, :distance

    def initialize(start_address, destination_address)
      @start_address = start_address
      @destination_address = destination_address
    end

    def execute
      raise StandardError, 'Abstract method'
    end
  end
end
