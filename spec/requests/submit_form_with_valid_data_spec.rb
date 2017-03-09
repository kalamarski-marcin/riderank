require 'rails_helper'

RSpec.describe 'submit form with valid data' do
  before :each do
    create(:taxi_provider)
    create(:user)
    visit '/'
  end

  it 'displays successfull message' do
    fill_in('taxi_ride_start_address', with: '1,2,3')
    fill_in('taxi_ride_destination_address', with: '1,2,4')
    fill_in('taxi_ride_price', with: '100')
    fill_in('taxi_ride_date', with: '1.1.2017')
    click_button('Save')
    expect(page).to have_content('Ride successfully created')
  end

end
