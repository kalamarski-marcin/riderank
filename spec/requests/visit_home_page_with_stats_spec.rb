require 'rails_helper'

RSpec.describe 'visit home page with stats' do
  before :each do
    create(:taxi_ride)
    visit '/'
  end

  it 'displays statistics' do
    within('//div.app') do
      expect(page).to have_xpath('//div[@class="ui four statistics tiny"]')
      expect(page).to have_xpath('//table')
      expect(page).to have_xpath('//h4')
    end
  end
end
