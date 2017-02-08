require 'rails_helper'

RSpec.describe TaxiRides::TaxiProviderRepository do
  describe 'queries' do
    context '.names_and_ids' do

      before :each do
        create(:taxi_provider)
        create(:taxi_provider)
        create(:taxi_provider)
        @result = TaxiRides::TaxiProviderRepository.names_and_ids
      end

      it 'returns an array' do
        expect(@result.size).to eq(3)
        expect(@result).to be_instance_of(Array)
      end

      it 'has elements being an array too' do
        expect(@result[0]).to be_instance_of(Array)
        expect(@result[1]).to be_instance_of(Array)
        expect(@result[2]).to be_instance_of(Array)
      end

      it 'has elements having names as a first element' do
        expect(@result[0][0]).to be_instance_of(String)
        expect(@result[1][0]).to be_instance_of(String)
        expect(@result[2][0]).to be_instance_of(String)
      end

      it 'has elements having ids as a second element' do
        expect(@result[0][1]).to be_instance_of(Integer)
        expect(@result[1][1]).to be_instance_of(Integer)
        expect(@result[2][1]).to be_instance_of(Integer)
      end
    end
  end
end
