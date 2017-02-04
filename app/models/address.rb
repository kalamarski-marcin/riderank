class Address < ApplicationRecord
  has_many :start_addresses_routes, class_name: 'Route', foreign_key: 'start_address_id'
  has_many :destination_addresses_routes, class_name: 'Route', foreign_key: 'destination_address_id'
end
