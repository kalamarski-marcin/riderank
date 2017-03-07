class AddUserToTaxiRides < ActiveRecord::Migration[5.0]
  def up
    add_column :taxi_rides, :user_id, :integer, index: true, null: false
    add_foreign_key :taxi_rides, :users, column: :user_id, primary_key: :id, name: 'fk_user_taxi_rides'
  end

  def down
    remove_column :taxi_rides, :user_id
    remove_foreign_key :taxi_rides, name: 'fk_user_taxi_rides'
  end

end
