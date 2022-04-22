require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  describe '/GET #index' do
    before do
      create(:user, id: 1)
      create(:music, id: 1)
      create(:favorite)
      create(:favorite)
      create(:favorite)
      get '/api/v1/favorites/index'
    end

    it 'returns an ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns with json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns 2 elements' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe '/GET #show' do
    let(:favorite) { create(:favorite) }

    before do
      create(:user, id: 1)
      create(:music, id: 1)
    end

    context 'when a favorite exist' do
      before { get "/api/v1/favorites/show/#{favorite.id}" }

      it { expect(response).to have_http_status(:ok) }

      it 'returns with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'when the favorite does not exist' do
      before do
        favorite.destroy
        get "/api/v1/favorites/show/#{favorite.id}"
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'does not return a json' do
        expect(response.content_type).not_to eq('application/json')
      end
    end
  end

  describe 'Post /Create' do
    let(:params) do
      {
        value: 0,
        user_id: 1,
        music_id: 1
      }
    end

    before do
      create(:user, id: 1)
      create(:music, id: 1)
    end

    context 'with valid params' do
      before do
        post '/api/v1/favorites/create', params: { favorite: params }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:created)
      end

      it 'creates the favorite' do
        new_favorite = Favorite.find_by(value: 0)
        expect(new_favorite).not_to be_nil
      end
    end

    context 'with invalid params' do
      before do
        post '/api/v1/favorites/create', params: { favorite: { user_id: 2 } }
      end

      it 'returns an unsuccessful response' do
        expect(response).to have_http_status(422)
      end

      it 'creates the favorite' do
        new_favorite = Favorite.find_by(user_id: 2)
        expect(new_favorite).to be_nil
      end
    end
  end

  describe 'DELETE /delete' do
    let(:favorite) { create(:favorite, id: 1) }

    before do
      create(:user, id: 1)
      create(:music, id: 1)
    end

    context 'when the favorite exist' do
      before { delete "/api/v1/favorites/delete/#{favorite.id}" }

      it { expect(response).to have_http_status(:ok) }

      it 'deletes the favorite' do
        deleted_favorite = Favorite.find_by(id: 1)
        expect(deleted_favorite).to be_nil
      end
    end

    context 'when the favorite does not exist' do
      before do
        favorite.destroy
        delete "/api/v1/favorites/delete/#{favorite.id}"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /update' do
    let(:favorite) { create(:favorite, value: 0) }

    before do
      create(:user, id: 1)
      create(:music, id: 1)
    end

    context 'when favorite exists' do
      before do
        put "/api/v1/favorites/update/#{favorite.id}", params: { favorite: { value: 1 } }
      end

      it 'respondes with an ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'changes title' do
        modified_favorite = Favorite.find_by(id: favorite.id)
        expect(modified_favorite.value).to eq(1)
      end
    end

    context 'when favorite does no exist' do
      before do
        put "/api/v1/favorites/update/#{1}", params: { favorite: { value: 1 } }
      end

      it 'respondes with an 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
