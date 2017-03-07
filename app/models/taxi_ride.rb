class TaxiRide < ApplicationRecord
  belongs_to :route
  belongs_to :user
  belongs_to :taxi_provider
end
