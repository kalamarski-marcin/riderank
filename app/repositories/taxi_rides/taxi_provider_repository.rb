module TaxiRides
  # :nodoc:
  module TaxiProviderRepository
    def self.names_and_ids
      TaxiProvider.order(name: :asc).pluck(:name, :id)
    end
  end
end
