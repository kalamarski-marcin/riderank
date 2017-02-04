class AddRouteToTaxiRides < ActiveRecord::Migration[5.0]
  def change
    add_reference :taxi_rides, :route, foreign_key: true
  end
end
