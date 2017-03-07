module TaxiRides
  class TaxiRidesStatsPresenter

    attr_reader :monthly_report, :weekly_stats, :daily_stats, :taxi_providers_stats

    def initialize(user_id)
      @monthly_report = TaxiRides::TaxiRideRepository.monthly_report
      @weekly_stats = TaxiRides::TaxiRideRepository.weekly_stats
      @daily_stats = TaxiRides::TaxiRideRepository.daily_stats
      @taxi_providers_stats = TaxiRides::TaxiRideRepository.taxi_providers_percentage_stats_by_user(user_id)
    end

    def stats?
      monthly_report? || weekly_stats? || taxi_providers_stats?
    end

    def daily_stats?
      @daily_stats.present?
    end

    def weekly_stats?
      @weekly_stats.present?
    end

    def monthly_report?
      @monthly_report.present?
    end

    def taxi_providers_stats?
      @taxi_providers_stats.present?
    end
  end
end
