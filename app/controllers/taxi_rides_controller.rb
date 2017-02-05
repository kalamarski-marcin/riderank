class TaxiRidesController < ApplicationController
  before_action :set_data, only: [:index, :create]

  # GET /
  # GET /taxi_rides
  def index; end

  # POST /taxi_rides
  def create
    if @form.validate
      if @form.save(create_taxi_ride_service)
        flash[:success] = 'Ride successfully created'
        redirect_to root_path, status: 301
      else
        render :index
      end
    else
      render :index
    end
  end

  private

  def create_taxi_ride_service
    TaxiRides::CreateTaxiRideService.new(
      @form.model,
      TaxiRides::GoogleMapsDistanceMatrixService.new( # or TaxiRides::RandomDistanceService
        @form.params[:start_address],
        @form.params[:destination_address]
      ),
      @form.params
    )
  end

  def set_data
    form_params = params[:taxi_ride].present? ? params[:taxi_ride] : {}
    @form = TaxiRides::Form.new(TaxiRide.new, form_params)
    @taxi_providers = TaxiRides::TaxiProviderRepository.names_and_ids
    @monthly_report = TaxiRides::TaxiRideRepository.monthly_report
  end
end
