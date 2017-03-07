require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'instance' do
    it 'has valid factory' do
      expect(user).to be_valid
    end

    it 'responds to :name' do
      expect(user).to respond_to(:name)
    end
  end
end
