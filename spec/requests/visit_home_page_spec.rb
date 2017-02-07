require 'rails_helper'

RSpec.describe 'visit home page' do
  before :each do
    @taxi_provider = create(:taxi_provider)
    visit '/'
  end

  it 'has RideRank title' do
    expect(page).to have_title('RideRank')
  end

  it 'displays logo' do
    within('//a.logo') do
      expect(page).to have_content('RideRank')
      expect(page).to have_css('span i.icon.taxi')
    end
  end

  it 'displays form with fields' do
    within('//div.app') do
      expect(page).to have_xpath('//form')
      expect(page).to have_xpath('//form/div/div/div/div/input[@name="taxi_ride[start_address]"]')
      expect(page).to have_xpath('//form/div/div/div/div/input[@name="taxi_ride[destination_address]"]')
      expect(page).to have_xpath('//form/div/div/div/div/input[@name="taxi_ride[price]"]')
      expect(page).to have_xpath('//form/div/div/div/div/select[@name="taxi_ride[taxi_provider_id]"]')
      expect(page).to have_xpath('//form/div/input[@name="commit"]')
    end
  end

  context 'form' do
    it 'has taxi providers select' do
      expect(page).to have_select('taxi_ride_taxi_provider_id', options: [@taxi_provider.name])
    end
  end
end
