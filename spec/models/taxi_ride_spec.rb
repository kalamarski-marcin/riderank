require 'rails_helper'

RSpec.describe TaxiRide, type: :model do
  let(:taxi_ride) { create(:taxi_ride) }

  describe 'instance' do
    it 'has valid factory' do
      expect(taxi_ride).to be_valid
    end

    it 'responds to :taxi_provider' do
      expect(taxi_ride).to respond_to(:taxi_provider)
    end

    it 'responds to :price' do
      expect(taxi_ride).to respond_to(:price)
    end

    it 'responds to :currency' do
      expect(taxi_ride).to respond_to(:currency)
    end

    it 'responds to :route' do
      expect(taxi_ride).to respond_to(:route)
    end
  end
end
