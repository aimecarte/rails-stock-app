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



#  describe 'Admin Page Access', type: :system do 
#     def login_as(user)
#       visit '/users/sign_in'
#       fill_in 'Email', with: user.email
#       fill_in 'Password', with: 'password'
#       click_button 'Log in'
#     end
 
#     it 'allows access to the admin page for admin users' do
#       login_as(admin_user)
#       visit '/admin/index'
#       expect(page).to have_content('Admin#index')
#     end
    
    # context 'when logged in as a regular user' do
    #   it 'denies access to the admin page' do
    #     sign_in regular_user
    #     visit '/admin/index'
    #     expect(page).to have_content('Access denied') # or whatever your app shows
    #     expect(current_path).to eq(root_path)
    #   end
    # end
    
    # context 'when not logged in' do
    #   it 'redirects to the login page' do
    #     visit '/admin/index'
    #     expect(current_path).to eq(new_user_session_path)
    #   end
    # end
  end
