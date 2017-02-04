module TaxiRides
  class TaxiRide < Struct.new(:start_address, :destination_address, :taxi_provider, :price)
    def initialize(start_address = '', destination_address = '', taxi_provider = '', price = '')
      super
    end

    private :start_address=, :destination_address=, :taxi_provider=, :price
  end
end
