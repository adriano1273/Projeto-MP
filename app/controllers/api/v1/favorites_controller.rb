class Api::V1::FavoritesController < ApplicationController
  def index
    favorites = Favorite.all
    render json: favorites, status: :ok
  end

  def show
    favorite = Favorite.find(params[:id])
    render json: favorite, status: :ok
  rescue StandardError
    head(:not_found)
  end

  def create
    favorite = Favorite.new(favorites_params)
    favorite.save!
    render json: favorite, status: :created
  rescue StandardError => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def update
    favorite = Favorite.find(params[:id])
    favorite.update!(favorites_params)
    render json: favorite, status: :ok
  rescue StandardError
    head(:unprocessable_entity)
  end

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
