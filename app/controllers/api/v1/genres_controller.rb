class Api::V1::GenresController < ApplicationController
    def index
        genres = Genre.all
        render json: genres, status: :ok
      end
    
      def show
        genre = Genre.find(params[:id])
        render json: genre, status: :ok
      rescue StandardError
        head(:not_found)
      end
    
      def create
        genre = Genre.new(genres_params)
        genre.save!
        render json: genre, status: :created
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end
    
      def update
        genre = Genre.find(params[:id])
        genre.update!(genres_params)
        render json: genre, status: :ok
      rescue StandardError
        head(:unprocessable_entity)
      end
    
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
