require 'rails_helper'

RSpec.describe "Admins", type: :request do
  let!(:admin_user) { User.create!(email: 'admin@example.com', password: 'password', first_name: 'asd', last_name: 'dsa', isAdmin: true) }
  let!(:regular_user) { User.create!(email: 'user@example.com', password: 'password', first_name: 'asd', last_name: 'dsa', isAdmin: false) }
  
  before do
    sign_in admin_user
  end

  describe 'GET /admin/index' do
    it  'after login, admin can go to admin page' do
      get '/admin/index'
      expect(response).to have_http_status(302)
    end
  end

  # describe 'POST /admin/users/new' do
  #   it 'admin can create an account' do
  #    user_params = {
  #     user: {
  #       email: "new_user@example.com",
  #       password: "password123",
  #       password_confirmation: "password123",
  #       first_name: "asd",
  #       last_name: "asd",
  #     }
  #   }
  #     post "/admin/users", params: user_params
  #     expect(response).to redirect_to(root_path)
  #     expect(User.last.email).to eq("new_user@example.com")
  #   end
  # end

  describe 'GET /admin/users/:id' do
    it 'admin can view specific profile' do
      get "/admin/users/#{admin_user.id}"
      expect(response).to have_http_status(302)
    end
  end

  before do
    sign_in regular_user
  end

 describe 'GET /admin/index' do
    it  'after login, user cannot go to admin/index' do
      get '/admin/index'
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
  




