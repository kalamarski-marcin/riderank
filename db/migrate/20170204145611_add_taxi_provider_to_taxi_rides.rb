class AddTaxiProviderToTaxiRides < ActiveRecord::Migration[5.0]
  def change
    add_reference :taxi_rides, :taxi_provider, foreign_key: true
  end
end
