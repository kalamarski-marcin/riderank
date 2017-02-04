FactoryGirl.define do
  factory :taxi_ride do
    route
    taxi_provider
    date DateTime.now
    price 100
    currency 'EUR'
  end
end
