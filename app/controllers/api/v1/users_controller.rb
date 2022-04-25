# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      acts_as_token_authentication_handler_for User, only: %i[logout show]
      wrap_parameters :user, include: %i[name password email is_admin]

      ##
      # <EU001> Eu como usuário quero entrar no aplicativo para definir meus gostos musicais, favoritar meus itens e montar playlists.
      # Faz o login do usuário
      def login
        user = User.find_by!(email: params[:email])
        if user.valid_password?(params[:password])
          render json: user, status: 200
        else
          head(:unauthorized)
        end
      rescue StandardError => e
        render json: e, status: 404
      end

      ##
      # <EU005> Eu como usuário quero fazer logout para encerrar a sessão.
      # Faz o logout do usuário
      def logout
        current_user.update! authentication_token: nil
        render json: { message: 'Volte sempre!' }
      rescue StandardError => e
        render json: e, status: :bad_request
      end

      ##
      # <EA002> Eu como administrador quero ver todos os usuários para efeito de gerenciamento.
      # Mostra ao administrador uma lista de todos os usuários da plataforma
      def index
        users = User.all
        render json: users, status: 200
      end

      ##
      # <EU004> Eu como usuário quero fazer cadastro para definir  meus gostos musicais, favoritar meus itens e montar playlists .
      # Cria um novo registro de usuário
      def create
        user = User.new(user_params)
        user.save!
        render json: user, status: 201
      rescue StandardError => e
        render json: e.message, status: 500
      end

      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Mostra aos administradores informações de um determinado usuário
      def show
        render json: current_user, status: 200
      end

      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Atualiza as informações do usuário
      def update
        user = User.find(params[:id])
        user.update!(user_params)
        render json: user, status: 200
      rescue StandardError
        head(:unprocessable_entity)
      end

      ##
      # <EA001> Eu como administrador quero editar características de música, usuários para evitar inconsistências ou consertar o sistema.
      # Apaga o usuário da base de dados
      def delete
        user = User.find(params[:id])
        user.destroy!
        render json: user, status: 200
      rescue StandardError
        head(:bad_request)
      end

      # Mostra a página de favoritos
      def my_favorites
        user = User.find(params[:id])
        favorites = user.favorites.where(value: 1)

        ids = favorites.pluck(:music_id)
        favorite_musics = Music.where(id: ids)

        render json: favorite_musics, status: 200
      rescue StandardError
        head(:bad_request)
      end

      ##
      # <EU002> Eu como usuário quero ser capaz de receber recomendações de música
      # Recomenda músicas aos usuários baseado no gênero
      def recomend_by_genre
        user = User.find(params[:id])
        favorites = user.favorites.where(value: 1)

        hated = user.favorites.where(value: -1)
        hated_ids = hated.pluck(:music_id)
        hated_musics = Music.where(id: hated_ids)

        music_reference = favorites.sample.music_id
        ids = favorites.pluck(:music_id)
        favorite_musics = Music.where(id: ids)
        music = Music.find_by(id: music_reference)

        suggested_genre = Genre.find_by(id: music.genre_id)
        suggested_musics = Music.where(genre_id: music.genre_id)

        suggestion = suggested_musics - favorite_musics
        suggestion -= hated_musics

        render json: suggestion, status: 200
      rescue StandardError
        head(:bad_request)
      end

      ##
      # <EU002> Eu como usuário quero ser capaz de receber recomendações de música
      # Recomenda músicas aos usuários baseado no interesse e favoritas
      def recomend_by_interest
        c_user = User.find(params[:id])
        favorites = c_user.favorites.where(value: 1)

        hated = c_user.favorites.where(value: -1)
        hated_ids = hated.pluck(:music_id)
        hated_musics = Music.where(id: hated_ids)

        ids = favorites.pluck(:music_id)
        c_user_interests = Music.where(id: ids)

        music_reference = favorites.sample.music_id
        users = Favorite.where(music_id: music_reference, value: 1).pluck(:user_id)
        aux_arr = [c_user.id]
        users -= aux_arr
        user_reference_id = users.sample

        user_reference = User.find_by(id: user_reference_id)
        uref_favorites = user_reference.favorites.where(value: 1)
        uref_ids = uref_favorites.pluck(:music_id)
        uref_interests = Music.where(id: uref_ids)

        suggestions = uref_interests - c_user_interests

        render json: suggestions, status: 200
      rescue StandardError => e
        render json: { message: e.message }, status: 400
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :is_admin)
      end
    end
  end
end
