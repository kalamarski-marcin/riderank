module TaxiRides
  # :nodoc:
  class Form < BaseForm

    def save(create_taxi_ride_service)
      create_taxi_ride_service.execute
    rescue TaxiRides::CreateTaxiRideServiceError => e
      sth_went_wrong do
        @logger.error e
      end
      false
    rescue StandardError => e
      sth_went_wrong do
        @logger.error e
      end
      false
    end

    def schema
      @schema = Dry::Validation.Schema do
        configure do
          def self.messages
            super.merge(
              en:
                {
                  errors: {
                    address_format?: 'type in following format: street, city, country',
                    equal_addresses: 'addresses must be different'
                  }
                }
            )
          end

          def address_format?(value)
            value =~ /^[^,]+(?:,[^,]+){2}$/
          end
        end

        required(:start_address).filled(:str?, :address_format?)
        required(:destination_address).filled(:str?, :address_format?)
        required(:price).filled(:number?, gteq?: '0')
        required(:taxi_provider_id).filled(:number?)

        rule(equal_addresses: [:start_address, :destination_address]) do |s, _d|
          s.not_eql?(value(:destination_address))
        end
      end
    end
  end
end
