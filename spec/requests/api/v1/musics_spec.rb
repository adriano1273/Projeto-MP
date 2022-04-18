# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Musics', type: :request do
  describe '/GET #index' do
    before do
      create(:music, title: 'musica1')
      create(:music, title: 'musica2')
      get '/api/v1/musics/index'
    end

    it 'returns an ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns with json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns 2 elements' do
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe '/GET #show' do
    let(:music) { create(:music) }

    context 'when a music exist' do
      before { get "/api/v1/musics/show/#{music.id}" }

      it { expect(response).to have_http_status(:ok) }

      it 'returns with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'when the music does not exist' do
      before do
        music.destroy
        get "/api/v1/musics/show/#{music.id}"
      end

      it { expect(response).to have_http_status(:not_found) }

      it 'does not return a json' do
        expect(response.content_type).not_to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'Post /Create' do
    let(:params) do
      {
        title: 'Go Like',
        description: 'Amazing music by Fox Stevenson'
      }
    end

    context 'with valid params' do
      before do
        post '/api/v1/musics/create', params: { music: params }
      end

      it 'returns a success response' do
        expect(response).to have_http_status(:created)
      end

      it 'creates the music' do
        new_music = Music.find_by(title: 'Go Like')
        expect(new_music).not_to be_nil
      end
    end
  end

  describe 'DELETE /delete' do
    let(:music) { create(:music, id: 1) }

    context 'when the music exist' do
      before { delete "/api/v1/musics/delete/#{music.id}" }

      it { expect(response).to have_http_status(:ok) }

      it 'deletes the music' do
        deleted_music = Music.find_by(id: 1)
        expect(deleted_music).to be_nil
      end
    end

    context 'when the music does not exist' do
      before do
        music.destroy
        delete "/api/v1/musics/delete/#{music.id}"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe 'PUT /update' do
    let(:music) { create(:music, title: 'Crossfire') }
    context 'when music exists' do
      before do
        put "/api/v1/musics/update/#{music.id}", params: { music: { title: 'Crossfire Remix' } }
      end

      it 'respondes with an ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'changes title' do
        modified_music = Music.find_by(id: music.id)
        expect(modified_music.title).to eq('Crossfire Remix')
      end
    end
  end
end
