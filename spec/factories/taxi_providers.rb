FactoryGirl.define do
  factory :taxi_provider do
    sequence :name do |n|
      "Taxi #{n}"
    end
  end
end
