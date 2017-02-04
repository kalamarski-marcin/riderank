class CreateTaxiRides < ActiveRecord::Migration[5.0]
  def change
    create_table :taxi_rides do |t|
      t.timestamp :date, null: false
    end
  end
end
