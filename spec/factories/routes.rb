FactoryGirl.define do
  factory :route do
    start_address { create(:address) }
    destination_address { create(:address) }
    distance 1000
  end
end
