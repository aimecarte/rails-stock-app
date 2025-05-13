require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:admin_user) { User.create!(email: 'admin@example.com', password: 'password', first_name: 'asd', last_name: 'dsa', isAdmin: true) }
  let!(:regular_user) { User.create!(email: 'user@example.com', password: 'password', first_name: 'asd', last_name: 'dsa', isAdmin: false) }
  describe '#can_search_stocks?' do
    context 'when the account is not approved' do
      it 'allows the user to search stocks' do
        user = User.new(isApproved: false)
        expect(user.can_search_stocks?).to be true
      end
    end

    context 'when the account is not approved' do
      it 'does not allow the user to buy or sell stocks' do
        user = User.new(isApproved: false)
        expect(user.can_trade_stocks?).to be false
      end
    end
  end
end
