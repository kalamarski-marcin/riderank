require 'rails_helper'

RSpec.describe Route, type: :model do
  let(:route) { create(:route) }

  describe 'instance' do
    it 'has valid factory' do
      expect(route).to be_valid
    end

    it 'responds to :start_address' do
      expect(route).to respond_to(:start_address)
    end

    it 'responds to :destination_address' do
      expect(route).to respond_to(:destination_address)
    end

    it 'responds to :distance' do
      expect(route).to respond_to(:distance)
    end

    it 'raises ActiveRecord::RecordNotUnique' do
      r = route.dup
      expect {
        create(
          :route,
          start_address: r.start_address,
          destination_address: r.destination_address,
          distance: r.distance
        )
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
