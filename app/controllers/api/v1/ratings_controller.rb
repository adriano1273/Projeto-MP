# frozen_string_literal: true

module Api
  module V1
    class RatingsController < ApplicationController
      ##
      # Mostra ao administrador todas as notas dadas por usuários as musicas
      def index
        ratings = Rating.all
        render json: ratings, status: :ok
      end

      ##
      # <EU013> Eu como usuário quero ser capaz de conceder, editar e remover uma avaliação de música para condecorar as músicas que gosto.
      # Mostra a nota que o usuário logado deu para a música em que ele está vendo
      def show
        rating = Rating.find(params[:id])
        render json: rating, status: :ok
      rescue StandardError
        head(:not_found)
      end

      ##
      # <EU013> Eu como usuário quero ser capaz de conceder, editar e remover uma avaliação de música para condecorar as músicas que gosto.
      # Adiciona em uma determinada música uma nota
      def create
        rating = Rating.new(rating_params)
        rating.save!
        render json: rating, status: :created
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      ##
      # <EU013> Eu como usuário quero ser capaz de conceder, editar e remover uma avaliação de música para condecorar as músicas que gosto.
      # Atualiza a nota que determinado usuário deu para uma certa música
      def update
        rating = Rating.find(params[:id])
        rating.update!(rating_params)
        render json: rating, status: :ok
      rescue StandardError
        head(:unprocessable_entity)
      end

      ##
      # <EU013> Eu como usuário quero ser capaz de conceder, editar e remover uma avaliação de música para condecorar as músicas que gosto.<EU013> Eu como usuário quero ser capaz de conceder, editar e remover uma avaliação de música para condecorar as músicas que gosto.
      # Remove a nota que determinado usuário deu para a música
      def delete
        rating = Rating.find(params[:id])
        rating.destroy!
        render json: rating, status: :ok
      rescue StandardError
        head(:not_found)
      end

      private

      def rating_params
        params.require(:rating).permit(
          :user_id,
          :music_id,
          :value
        )
      end
    end
  end
end
