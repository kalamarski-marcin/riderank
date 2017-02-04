module TaxiRides
  # :nodoc:
  module TaxiRideRepository
    def self.create(taxi_ride:, route:, price:, taxi_provider:)
      taxi_ride.taxi_provider = taxi_provider
      taxi_ride.route = route
      taxi_ride.price = price
      taxi_ride.date = DateTime.now
      taxi_ride.save
    end

    def self.weekly_report
    end

    def self.monthly_report
      ::TaxiRide
        .readonly
        .select([
                  "CONCAT_WS(' ',SUM(routes.distance),'km') AS distance",
                  "CONCAT_WS(' ',ROUND(AVG(routes.distance)::numeric,2),'km') AS avg_distance",
                  "CONCAT_WS(' ', ROUND(AVG(taxi_rides.price)::numeric,2), taxi_rides.currency) AS avg_price",
                  "to_char(taxi_rides.date, 'fmMonth, fmDDth') AS day",
                  "string_agg(distinct taxi_providers.name,', ') as taxi"
                ])
        .joins([:route, :taxi_provider])
        .where([
                 "taxi_rides.currency='EUR'",
                 'extract(month from now()) = extract(month from taxi_rides.date)',
                 'extract(year from now()) = extract(year from taxi_rides.date)'
               ])
        .group('day, taxi_rides.currency')
        .order('day ASC')
    end
  end
end
