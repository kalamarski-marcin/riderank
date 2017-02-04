require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { create(:address) }

  describe 'instance' do
    it 'has valid factory' do
      expect(address).to be_valid
    end

    it 'responds to :address' do
      expect(address).to respond_to(:address)
    end

    it 'raises ActiveRecord::ActiveRecord::RecordNotUnique' do
      expect { create(:address, address: address.address) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
