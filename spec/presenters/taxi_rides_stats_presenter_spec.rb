require "rails_helper"

RSpec.describe TaxiRides::TaxiRidesStatsPresenter do
  describe 'initialize when no taxi rides' do
    before :each do
      user = create(:user)
      @taxi_rides_stats_presenter = TaxiRides::TaxiRidesStatsPresenter.new(user.id)
    end

    context 'when stats? called' do
      it 'returs false' do
        expect(@taxi_rides_stats_presenter.stats?).to be_falsey
      end
    end
  end

  describe 'initialize when taxi rides exist' do
    before :each do
      taxi_ride = create(:taxi_ride)
      @taxi_rides_stats_presenter = TaxiRides::TaxiRidesStatsPresenter.new(taxi_ride.user_id)
    end

    context 'when stats? called' do
      it 'returs true' do
        expect(@taxi_rides_stats_presenter.stats?).to be_truthy
      end
    end

    context 'when daily_stats? called' do
      it 'returns true' do
        expect(@taxi_rides_stats_presenter.daily_stats?).to be_truthy
      end
    end

    context 'when weekly_stats? called' do
      it 'returns true' do
        expect(@taxi_rides_stats_presenter.weekly_stats?).to be_truthy
      end
    end

    context 'when monthly_report?' do
      it 'returns true' do
        expect(@taxi_rides_stats_presenter.monthly_report?).to be_truthy
      end
    end

    context 'when taxi_providers_stats? called' do
      it 'returns true' do
        expect(@taxi_rides_stats_presenter.taxi_providers_stats?).to be_truthy
      end
    end
  end
end
