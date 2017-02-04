module TaxiRides
  # :nodoc:
  class Form
    attr_reader :errors, :taxi_ride, :params

    def initialize(taxi_ride, params)
      @taxi_ride = taxi_ride
      @params = params
      @errors = {}
    end

    def validate
      schema
      result = @schema.call(@params)
      @errors = result.errors
      result.success?
    end

    def save(create_taxi_ride_service)
      result = create_taxi_ride_service.execute
      sth_went_wrong unless result
      result
    rescue TaxiRides::CreateTaxiRideServiceError => e
      @errors = { critical: e.message }
      false
    rescue
      sth_went_wrong
      false
    end

    private

    def sth_went_wrong
      @errors = { critical: 'Something went wrong. Please contact us'}
    end

    def schema
      @schema = Dry::Validation.Schema do
        configure do
          def self.messages
            super.merge(
              en:
                {
                  errors: {
                    address_format?: 'must have valid format: street, city, country',
                    equal_addresses: 'must be different'
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
