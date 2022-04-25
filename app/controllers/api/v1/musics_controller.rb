# frozen_string_literal: true

module Api
  module V1
    class MusicsController < ApplicationController
      ##
      # <EU011> Eu como usuário quero ser capaz de ver a lista de todas as músicas para escolher a que mais me agrada.
      # Mostra ao usuário uma lista com todas as músicas
      def index
        musics = Music.all
        render json: musics, status: :ok
      end

      ##
      # <EU012> Eu como usuário quero ser capaz de ver a página da música para adicionar aos favoritos, avaliar e ver outros usuários que favoritaram a música.
      # Mostra ao usuário a página de uma determinada música
      def show
        music = Music.find(params[:id])

        if music.ratings.blank?
          average_rating = 0
        else
          average_rating = music.ratings.average(:value).round(1)
        end

        music.average = average_rating

        render json: music, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: 404
      end
      
      ##
      # <EA003> Eu como administrador quero adicionar músicas à plataforma para que os usuários tenham mais opções de escolha.
      # Adiciona uma nova música ao sistema
      def create
        music = Music.new(music_params)
        music.save!
        render json: music, status: :created
      rescue StandardError
        head(:unprocessable_entity)
      end

      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Atualiza as informações de uma determinada música
      def update
        music = Music.find(params[:id])
        music.update!(music_params)
        render json: music, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :bad_request
      end

      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Deleta do sistema uma música
      def delete
        music = Music.find(params[:id])
        music.destroy!
        render json: music, status: :ok
      rescue StandardError
        head(:not_found)
      end

      ##
      # <EU012> Eu como usuário quero ser capaz de ver a página da música para adicionar aos favoritos, avaliar e ver outros usuários que favoritaram a música.
      # Mostra uma lista de usuários que favoritaram certa música.
      def favorited_by
        favorites = Favorite.where(music_id: params[:id], value: 1)
        user_ids = favorites.pluck(:user_id)
        users = User.where(id: user_ids)
        render json: users, status: :ok
        
      rescue StandardError
        head(:not_found)
      end

      private

      def music_params
        params.require(:music).permit(
          :title,
          :description,
          :photo
        )
      end
    end
  end
end
