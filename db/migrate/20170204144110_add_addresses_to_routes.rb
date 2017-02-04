class AddAddressesToRoutes < ActiveRecord::Migration[5.0]
  def up
    add_column :routes, :start_address_id, :integer, index: true, null: false
    add_column :routes, :destination_address_id, :integer, index: true, null: false

    add_foreign_key :routes, :addresses, column: :start_address_id, primary_key: :id, name: 'fk_routes_addresses_start_address'
    add_foreign_key :routes, :addresses, column: :destination_address_id, primary_key: :id, name: 'fk_routes_addresses_destination_address'
  end

  def down
    remove_foreign_key :routes, name: 'fk_routes_addresses_start_address'
    remove_foreign_key :routes, name: 'fk_routes_addresses_destination_address'

    remove_column :routes, :start_address_id
    remove_column :routes, :destination_address_id
  end
end
