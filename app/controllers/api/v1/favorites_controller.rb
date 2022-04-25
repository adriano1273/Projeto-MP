# frozen_string_literal: true

module Api
  module V1
    class FavoritesController < ApplicationController
      ##
      # <EU009> Eu como usuário quero ser capaz de ver minha lista de músicas favoritas para escutá-las.
      # Mostra ao usuário todas suas músicas favoritas
      def index
        favorites = Favorite.all
        render json: favorites, status: :ok
      end

      ##
      # <EU009> Eu como usuário quero ser capaz de ver minha lista de músicas favoritas para escutá-las.
      # Mostra a página da música através da página de favoritos
      def show
        favorite = Favorite.find(params[:id])
        render json: favorite, status: :ok
      rescue StandardError
        head(:not_found)
      end

      ##
      # <EU003> Eu como usuário quero ser capaz de favoritar músicas para ter fácil acesso à elas mais tarde.
      # Adiciona música a lista de favoritas do usuário logado
      def create
        favorite = Favorite.new(favorites_params)
        if Favorite.where(user_id: favorite.user_id, music_id: favorite.music_id).size.zero?
          favorite.save!
          render json: favorite, status: :created
        else
          render json: { message: 'essa musica ja esta em sua lista de favoritos' }, status: :ok
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      ##
      # <EU010> Eu como usuário quero ser capaz de remover músicas da lista de favoritas para atualizar meus gostos e recomendações.
      # Atualiza os parâmetros da música na lista de favoritos
      def update
        favorite = Favorite.find(params[:id])
        favorite.update!(favorites_params)
        render json: favorite, status: :ok
      rescue StandardError
        head(:unprocessable_entity)
      end

      ##
      # <EU010> Eu como usuário quero ser capaz de remover músicas da lista de favoritas para atualizar meus gostos e recomendações.
      # Remove a música da lista de favoritos do usuário
      def delete
        favorite = Favorite.find(params[:id])
        favorite.destroy!
        render json: favorite, status: :ok
      rescue StandardError
        head(:not_found)
      end

      private

      def favorites_params
        params.require(:favorite).permit(
          :user_id,
          :music_id,
          :value
        )
      end
    end
  end
end
