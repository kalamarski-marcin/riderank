module TaxiRides
  # :nodoc:
  module TaxiRideRepository
    def self.save(taxi_ride:, route:, price:, taxi_provider:)
      taxi_ride.taxi_provider = taxi_provider
      taxi_ride.route = route
      taxi_ride.price = price.to_f
      taxi_ride.date = DateTime.now
      taxi_ride.save
    end

    def self.daily_stats
      ::TaxiRide
        .readonly
        .select([
                  "DISTINCT CONCAT_WS(' ',SUM(routes.distance),'km') AS sum_distance",
                  "CONCAT_WS(' ',SUM(taxi_rides.price), taxi_rides.currency) AS sum_price"
                ])
        .joins([:route])
        .where(
          "taxi_rides.currency='EUR' AND
               extract(day from now()) = extract(day from taxi_rides.date) AND
               extract(year from now()) = extract(year from taxi_rides.date)
               ")
        .group('taxi_rides.currency')
        .order("sum_distance ASC")
        .first
    end

    def self.weekly_stats
      ::TaxiRide
        .readonly
        .select([
                  "DISTINCT CONCAT_WS(' ',SUM(routes.distance),'km') AS sum_distance",
                  "CONCAT_WS(' ',SUM(taxi_rides.price), taxi_rides.currency) AS sum_price"
                ])
        .joins([:route])
        .where(
               "taxi_rides.currency='EUR' AND
               extract(week from now()) = extract(week from taxi_rides.date) AND
               extract(year from now()) = extract(year from taxi_rides.date)
               ")
        .group('taxi_rides.currency')
        .order("sum_distance ASC")
        .first
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
        .where("
                 taxi_rides.currency='EUR' AND
                 extract(month from now()) = extract(month from taxi_rides.date) AND
                 extract(year from now()) = extract(year from taxi_rides.date)
               ")
        .group('day, taxi_rides.currency')
        .order('day ASC')
    end
  end
end
