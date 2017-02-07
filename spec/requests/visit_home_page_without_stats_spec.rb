require 'rails_helper'

RSpec.describe 'visit home page without stats' do
  before :each do
    visit '/'
  end

  it 'does not display statistics' do
    within('//div.app') do
      expect(page).to_not have_xpath('//div[@class="ui four statistics tiny"]')
      expect(page).to_not have_xpath('//table')
      expect(page).to_not have_xpath('//h4')
    end
  end
end
