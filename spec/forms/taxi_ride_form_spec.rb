require 'rails_helper'

RSpec.describe TaxiRides::Form do
  describe 'validates' do
    before :each do
      @taxi_ride = double()
    end

    context 'with invalid attributes' do
      context 'when missing' do

        before :each do
          @form = TaxiRides::Form.new(@taxi_ride, {})
        end

        it 'returns false' do
          expect(@form.validate).to be_falsey
        end

        it 'start_address is missing' do
          @form.validate
          expect(@form.errors[:start_address]).to eq(["is missing"])
        end

        it 'destination_address is missing' do
          @form.validate
          expect(@form.errors[:destination_address]).to eq(["is missing"])
        end

        it 'taxi_provider_id is missing' do
          @form.validate
          expect(@form.errors[:taxi_provider_id]).to eq(["is missing"])
        end

        it 'price is missing' do
          @form.validate
          expect(@form.errors[:price]).to eq(["is missing"])
        end

        it 'date is missing' do
          @form.validate
          expect(@form.errors[:date]).to eq(["is missing"])
        end
      end

      context 'when empty' do
        before :each do
          params = {
            start_address: '',
            destination_address: '',
            taxi_provider_id: '',
            price: '',
            date: ''
          }
          @form = TaxiRides::Form.new(@taxi_ride, params)
        end

        it 'returns false' do
          expect(@form.validate).to be_falsey
        end

        it 'date must be filled' do
          @form.validate
          expect(@form.errors[:date]).to eq(["must be filled"])
        end

        it 'start_address must be filled' do
          @form.validate
          expect(@form.errors[:start_address]).to eq(["must be filled"])
        end

        it 'destination_address must be filled' do
          @form.validate
          expect(@form.errors[:destination_address]).to eq(["must be filled"])
        end

        it 'taxi_provider_id must be filled' do
          @form.validate
          expect(@form.errors[:taxi_provider_id]).to eq(["must be filled"])
        end

        it 'price must be filled' do
          @form.validate
          expect(@form.errors[:price]).to eq(["must be filled"])
        end
      end

      context 'when invalid' do
        it 'start_address must have valid format' do
          form = TaxiRides::Form.new(@taxi_ride, { start_address: '1,2' })
          form.validate
          expect(form.errors[:start_address]).to eq(["type in following format: street, city, country"])
        end

        it 'destination_address must have valid format' do
          form = TaxiRides::Form.new(@taxi_ride, { destination_address: '1,2' })
          form.validate
          expect(form.errors[:destination_address]).to eq(["type in following format: street, city, country"])
        end

        it 'taxi_provider_id must be number' do
          form = TaxiRides::Form.new(@taxi_ride, { taxi_provider_id: "a" })
          form.validate
          expect(form.errors[:taxi_provider_id]).to eq(["must be a number"])
        end

        it 'price must be number' do
          form = TaxiRides::Form.new(@taxi_ride, { price: "a" })
          form.validate
          expect(form.errors[:price]).to eq(["must be a number"])
        end

        it 'price must be >= 0' do
          form = TaxiRides::Form.new(@taxi_ride, { price: "-1" })
          form.validate
          expect(form.errors[:price]).to eq(["must be greater than or equal to 0"])
        end

        it 'start_address has to different than destination_address' do
          form = TaxiRides::Form.new(@taxi_ride, { start_address: "1,2,3", destination_address: "1,2,3" })
          form.validate
          expect(form.errors[:equal_addresses]).to eq(["addresses must be different"])
        end
      end
    end

    context 'with valid attributes' do
      before :each do
        params = {
          start_address: '1,2,3',
          destination_address: '2,3,4',
          taxi_provider_id: '1',
          price: '10',
          date: '1.1.2017'
        }
        @form = TaxiRides::Form.new(@taxi_ride, params)
      end

      it 'returns true' do
        expect(@form.validate).to be_truthy
      end
    end
  end

  describe 'saves' do
    before :each do
      @taxi_ride = double()
      @params = double()
      @form = TaxiRides::Form.new(@taxi_ride, @params)
    end

    context 'when successfully' do
      it 'returns true' do
        create_taxi_ride_service = double()
        allow(create_taxi_ride_service).to receive(:execute) { true }
        expect(@form.save(create_taxi_ride_service)).to be_truthy
      end
    end

    context 'with failure' do
      it 'raises TaxiRides::CreateTaxiRideServiceError' do
        create_taxi_ride_service = double()
        e = TaxiRides::CreateTaxiRideServiceError
        allow(create_taxi_ride_service).to receive(:execute).and_raise(e)
        expect(@form.save(create_taxi_ride_service)).to be_falsey
      end
    end
  end
end
