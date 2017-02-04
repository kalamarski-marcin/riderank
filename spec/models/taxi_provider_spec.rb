require 'rails_helper'

RSpec.describe TaxiProvider, type: :model do
  let(:taxi_provider) { create(:taxi_provider) }

  describe 'instance' do
    it 'has valid factory' do
      expect(taxi_provider).to be_valid
    end

    it 'responds to :name' do
      expect(taxi_provider).to respond_to(:name)
    end
  end
end
