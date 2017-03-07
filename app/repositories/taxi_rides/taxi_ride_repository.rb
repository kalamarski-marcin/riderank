module TaxiRides
  # :nodoc:
  module TaxiRideRepository

    SELECT_STATS = [
      "DISTINCT CONCAT_WS(' ',SUM(routes.distance),'km') AS sum_distance",
      "CONCAT_WS(' ',SUM(taxi_rides.price), taxi_rides.currency) AS sum_price"
    ]

    def self.save(taxi_ride:, route:, price:, taxi_provider:, user:)
      taxi_ride.taxi_provider = taxi_provider
      taxi_ride.route = route
      taxi_ride.price = price.to_f
      taxi_ride.date = DateTime.now
      taxi_ride.user = user
      taxi_ride.save
    end

    def self.taxi_providers_percentage_stats_by_user(user_id)
      ::TaxiRide
        .readonly
        .select([
                  "taxi_providers.name",
                  "COUNT(taxi_rides.taxi_provider_id) amount",
                  "CONCAT_WS('', ROUND((count(taxi_rides.taxi_provider_id) * 100)::numeric / (select count(*) from taxi_rides inner join users on taxi_rides.user_id = users.id inner join taxi_providers on taxi_rides.taxi_provider_id = taxi_providers.id where users.id = #{user_id}), 2),'%') AS percent"
                ])
        .joins([:user, :taxi_provider])
        .where(user_id: user_id)
        .group('taxi_providers.name')
        .order('taxi_providers.name ASC')
    end

    def self.daily_stats
      ::TaxiRide
        .readonly
        .select(SELECT_STATS)
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
        .select(SELECT_STATS)
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
                  "string_agg(distinct taxi_providers.name,', ') as taxis"
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
