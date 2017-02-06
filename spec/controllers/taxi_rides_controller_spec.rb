require 'rails_helper'

RSpec.describe TaxiRidesController, type: :controller do
  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
      expect(flash[:success]).to be_blank
    end

    it 'populates an array of taxi providers' do
      create(:taxi_provider)
      expected_taxi_providers = TaxiRides::TaxiProviderRepository.names_and_ids
      get :index
      expect(assigns(:taxi_providers)).to eq(expected_taxi_providers)
    end

    it 'populates an array of taxi montlhy statistics' do
      create(:taxi_ride)
      expected_monthly_report = TaxiRides::TaxiRideRepository.monthly_report
      get :index
      expect(assigns(:monthly_report)).to eq(expected_monthly_report)
    end

  end

  describe 'POST #taxi_rides' do

    before :each do
      @params = { taxi_ride: {price: 5}}
    end

    context 'with invalid attributes' do
      it 'does not save the new taxi ride' do
        expect { post :create, params: @params }.to_not change(TaxiRide, :count)
      end

      it 'does not show flash' do
        post :create, params: @params
        expect(flash[:success]).to be_blank
      end

      it 'does not redirect to /' do
        post :create, params: @params
        expect(response).to_not redirect_to '/'
      end

      it 'does not clear params' do
        post :create, params: @params
        expect(request.params[:taxi_ride][:price]).to eq("5")
      end
    end

    before :each do
      @taxi_provider = create(:taxi_provider)
    end

    context 'with valid attributes' do
      it 'does save the new taxi ride' do
        expect {
          post :create, params: { taxi_ride: { start_address: '1,2,3', destination_address: '1,2,4', taxi_provider_id: @taxi_provider.id, price: 100}}
        }.to change(TaxiRide, :count)
      end

      it 'redirects to root' do
        post :create, params: { taxi_ride: { start_address: '1,2,3', destination_address: '1,2,4', taxi_provider_id: @taxi_provider.id, price: 100}}
        expect(response).to redirect_to '/'
      end

      it 'renders flash' do
        post :create, params: { taxi_ride: { start_address: '1,2,3', destination_address: '1,2,4', taxi_provider_id: @taxi_provider.id, price: 100}}
        redirect_to '/'
        expect(flash[:success]).to eq('Ride successfully created')
      end
    end
  end
end
