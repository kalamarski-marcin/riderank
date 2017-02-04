module TaxiRides
  # :nodoc:
  module RouteRepository
    def self.create(start_address:, destination_address:, distance:)
      Route.create(
        start_address: start_address,
        destination_address: destination_address,
        distance: distance
      )
    end

    def self.find_by_addresses(start_address:, destination_address:)
      Route.where(
        start_address: start_address,
        destination_address: destination_address
      ).limit(1).first
    end
  end
end
