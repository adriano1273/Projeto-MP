# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    before do
      create(:user, email: 'email1@email')
      create(:user, email: 'email2@email')
      create(:user, email: 'email3@email')
      get '/api/v1/users/index'
    end

    it { expect(response).to have_http_status(200) }

    it 'returns a json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns 3 elements' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /show' do
    let(:user1) { create(:user) }

    context 'when user is logged' do
      before do
        get '/api/v1/users/show', headers: {
          'X-User-Token': user1.email,
          'X-User-Email': user1.authentication_token
        }
      end
      # it { expect(response).to have_http_status(200) }
    end

    context 'when user is not logged or headers are wrong' do
      before do
        get '/api/v1/users/show', headers: {
          'X-User-Token': nil,
          'X-User-Email': nil
        }
      end

      it { expect(response).to have_http_status(302) }
    end
  end

  describe 'POST /create' do
    let(:params) do
      {
        name: 'nome',
        email: 'nome@nome',
        password: '123456',
        is_admin: false
      }
    end

    let(:params_wrong) do
      {
        name: 'nome2',
        password: '123456',
        is_admin: false
      }
    end

    context 'when the params are right' do
      before do
        post '/api/v1/users/create', params: { user: params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'should create the user' do
        new_user = User.find_by(name: 'nome')
        expect(new_user).not_to be_nil
      end
    end

    context 'when the params are wrong' do
      before do
        post '/api/v1/users/create', params: { user: params_wrong }
      end

      it { expect(response).to have_http_status(500) }

      it 'should not create the user' do
        new_user = User.find_by(name: 'nome2')
        expect(new_user).to be_nil
      end
    end
  end

  describe 'DELETE /delete' do
    let(:usuario) { create(:user, name: 'nome') }

    context 'when the user exists' do
      before do
        delete "/api/v1/users/delete/#{usuario.id}"
      end

      it { expect(response).to have_http_status(:ok) }

      it 'deletes the user' do
        deleted_user = User.find_by(name: 'nome')
        expect(deleted_user).to be_nil
      end
    end

    context 'when the user does not exists' do
      before do
        usuario.destroy
        delete "/api/v1/users/delete/#{usuario.id}"
      end

      it { expect(response).to have_http_status(:bad_request) }
    end
  end
end
