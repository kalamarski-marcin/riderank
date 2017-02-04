FactoryGirl.define do
  factory :address do 
    sequence :address do |n|
      "#{Faker::Address.street_address}#{n}, #{Faker::Address.city}, #{Faker::Address.country}"
    end
  end
end
