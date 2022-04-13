# frozen_string_literal: true

module Api
  module V1
    class RatingsController < ApplicationController
      def index
        ratings = Rating.all
        render json: ratings, status: :ok
      end

      def show
        rating = Rating.find(params[:id])
        render json: rating, status: :ok
      rescue StandardError
        head(:not_found)
      end

      def create
        rating = Rating.new(rating_params)
        rating.save!
        render json: rating, status: :created
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def update
        rating = Rating.find(params[:id])
        rating.update!(rating_params)
        render json: rating, status: :ok
      rescue StandardError
        head(:unprocessable_entity)
      end

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
          # :music_id,
          :value
        )
      end
    end
  end
end
