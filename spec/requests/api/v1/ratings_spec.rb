require 'rails_helper'

RSpec.describe "Api::V1::Ratings", type: :request do
  describe '/GET index' do
    before do
      create(:rating, value: 3)
      create(:rating, value: 5)
      get '/api/v1/ratings/index'
    end

    it { expect(response).to have_http_status(:ok) }
  end
  describe '/GET #show' do
    let(:avaliacao) { create(:rating) }
    context 'when rating exist' do
      before do
        create(:rating, value: 2)
        create(:rating, value: 1)
        get "/api/v1/ratings/show/#{avaliacao.id}"

        it { expect(response).to have_http_status(:ok) }
      end
    end

    context 'when rating does not exist' do
      before do
        avaliacao.destroy
        get "/api/v1/ratings/show/#{avaliacao.id}"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'POST /Create' do
    let(:params) do
      {
        user_id: 3,
        music_id: 7,
        value: 4
      }
    end

    context 'with valid params' do
      before do
        post '/api/v1/ratings/create', params: { rating: params }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:created)
      end

      it 'creates the rating' do
        new_rating = Rating.find_by(user_id: 3)
        expect(new_rating).not_to be_nil
      end
    end
  end

  describe 'DELETE /delete' do
    let(:avaliacao) { create(:rating, id: 1) }

    context 'when rating exist' do
      before { delete "/api/v1/ratings/delete/#{avaliacao.id}" }
      it { expect(response).to have_http_status(:ok) }

      it 'deletes the rating' do
        deleted_rating = Rating.find_by(id: 1)
        expect(deleted_rating).to be_nil
      end
    end

    context 'when rating does not exist' do
      before do
        avaliacao.destroy
        delete "/api/v1/ratings/delete/#{avaliacao.id}"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /update' do
    let(:avaliacao) { create(:rating, value: 0) }
    context 'when rating exists' do
      before do
        put "/api/v1/ratings/update/#{avaliacao.id}", params: { rating: { value: 5 } }
      end

      it 'responds with and ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'changes rating' do
        updated_rating = Rating.find_by(id: avaliacao.id)
        expect(updated_rating.value).to eq(5)
      end
    end
  end
end
