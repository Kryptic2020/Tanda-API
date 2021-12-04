require 'rails_helper'

RSpec.describe 'Auth requests' do
    describe 'User API', type: :request do
    
      it 'return user' do
        FactoryBot.create(:user, id:1, username:'john',email:"test@gmail.com", password:'123456', password_confirmation:'123456')
        post '/api/auth/current-user', params: {email: 'test@gmail.com'}
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(7)
      end

      it 'update user' do
        FactoryBot.create(:user, id:1,username:'john',email:"test@gmail.com", password:'123456', password_confirmation:'123456')
        
        put '/api/auth/update', params: {user_id:1, username:'johnny',email:"test2@gmail.com", password:'123456'}

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end
  end  