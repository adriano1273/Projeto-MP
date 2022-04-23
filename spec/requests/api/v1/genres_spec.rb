require 'rails_helper'

RSpec.describe "Api::V1::Genres", type: :request do
  describe '/GET #index' do
    before do
      create(:genre)
      get '/api/v1/genres/index'
    end

    it 'returns an ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns with json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns 2 elements' do
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe '/GET #show' do
    let(:genre) { create(:genre) }

    context 'when a genre exist' do
      before { get "/api/v1/genres/show/#{genre.id}" }

      it { expect(response).to have_http_status(:ok) }

      it 'returns with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'when the genre does not exist' do
      before do
        genre.destroy
        get "/api/v1/genres/show/#{genre.id}"
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
        name: "string"
      }
    end

    context 'with valid params' do
      before do
        post '/api/v1/genres/create', params: { genre: params }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:created)
      end

      it 'creates the genre' do
        new_genre = Genre.find_by(name: "string")
        expect(new_genre).not_to be_nil
      end
    end

    context 'with invalid params' do
      before do
        post '/api/v1/genres/create', params: { genre: { name: nil } }
      end

      it 'returns an unsuccessful response' do
        expect(response).to have_http_status(422)
      end

    end
  end

  describe 'DELETE /delete' do
    let(:genre) { create(:genre, id: 1) }

    context 'when the genre exist' do
      before { delete "/api/v1/genres/delete/#{genre.id}" }

      it { expect(response).to have_http_status(:ok) }

      it 'deletes the genre' do
        deleted_genre = Genre.find_by(id: 1)
        expect(deleted_genre).to be_nil
      end
    end

    context 'when the genre does not exist' do
      before do
        genre.destroy
        delete "/api/v1/genres/delete/#{genre.id}"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /update' do
    let(:genre) { create(:genre, name: "fizz") }

    context 'when genre exists' do
      before do
        put "/api/v1/genres/update/#{genre.id}", params: { genre: { name: "buzz" } }
      end

      it 'respondes with an ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'changes title' do
        modified_genre = Genre.find_by(id: genre.id)
        expect(modified_genre.name).to eq("buzz")
      end
    end

    context 'when genre does no exist' do
      before do
        put "/api/v1/genres/update/#{5}", params: { genre: { name: "buzz" } }
      end

      it 'respondes with an 422 status' do
        expect(response).to have_http_status(422)
      end
    end
  end
end