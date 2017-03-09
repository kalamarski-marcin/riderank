require 'rails_helper'

RSpec.describe 'submit form with invalid data' do
  before :each do
    create(:taxi_provider)
    visit '/'
  end

  context 'when params are empty' do
    it 'displays errors' do
      click_button('Save')
      expect(page).to have_content('must be filled', count: 4)
      expect(page).to have_xpath('//div[@class="field error"]', count: 3)
      expect(page).to have_xpath('//div[@class="ui pointing up red basic label"]', count: 4)
    end
  end

  context 'when params are invalid' do
    it 'displays errors' do
      fill_in('taxi_ride_start_address', with: '1,2')
      fill_in('taxi_ride_destination_address', with: '1,2')
      fill_in('taxi_ride_price', with: 'a')
      click_button('Save')
      expect(page).to have_content('type in following format: street, city, country', count: 2)
      expect(page).to have_content('must be a number', count: 1)
      expect(page).to have_xpath('//div[@class="field error"]', count: 3)
      expect(page).to have_xpath('//div[@class="ui pointing up red basic label"]', count: 4)
    end
  end

  context 'when addresses are the same' do
    it 'displays error' do
      fill_in('taxi_ride_start_address', with: '1,2,3')
      fill_in('taxi_ride_destination_address', with: '1,2,3')
      click_button('Save')
      expect(page).to have_content('addresses must be different', count: 1)
    end
  end

end
