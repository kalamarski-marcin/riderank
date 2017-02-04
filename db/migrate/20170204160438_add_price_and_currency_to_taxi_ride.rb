class AddPriceAndCurrencyToTaxiRide < ActiveRecord::Migration[5.0]
  def change
    add_column :taxi_rides, :price, :decimal, precision: 10, scale: 2, null: false
    add_column :taxi_rides, :currency, :string, default: 'EUR', null: false
  end
end
