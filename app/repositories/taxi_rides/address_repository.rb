module TaxiRides
  # :nodoc:
  module AddressRepository
    def self.find_or_create(address:)
      Address.find_or_create_by(
        address: address
      )
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end
end
