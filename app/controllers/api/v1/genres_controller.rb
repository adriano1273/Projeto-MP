class Api::V1::GenresController < ApplicationController
      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Mostra para o administrador todos os gêneros musicais
      def index
        genres = Genre.all
        render json: genres, status: :ok
      end
      
      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.    
      # Mostra para o administrador todas as informações sobre um gênero musical
      def show
        genre = Genre.find(params[:id])
        render json: genre, status: :ok
      rescue StandardError
        head(:not_found)
      end
      
      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Cria um novo gênero musical
      def create
        genre = Genre.new(genres_params)
        genre.save!
        render json: genre, status: :created
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end
      
      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Atualiza as informações de um determinado gênero musical
      def update  
        genre = Genre.find(params[:id])
        genre.update!(genres_params)
        render json: genre, status: :ok
      rescue StandardError
        head(:unprocessable_entity)
      end
      
      ##
      # <EA001> Eu como administrador quero editar características de música, usuários e gêneros musicais para evitar inconsistências ou consertar o sistema.
      # Apaga um determinado gênero musical
      def delete
        genre = Genre.find(params[:id])
        genre.destroy!
        render json: genre, status: :ok
      rescue StandardError
        head(:not_found)
      end
    
      private
    
      def genres_params
        params.require(:genre).permit(
          :name
        )
      end
end
