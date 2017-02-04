class Route < ApplicationRecord
  has_many :taxi_rides
  belongs_to :destination_address, class_name: 'Address', foreign_key: :destination_address_id
  belongs_to :start_address, class_name: 'Address', foreign_key: :start_address_id
end
