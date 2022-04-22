# frozen_string_literal: true

module Api
  module V1
    class MusicsController < ApplicationController
      def index
        musics = Music.all
        render json: musics, status: :ok
      end

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

      def create
        music = Music.new(music_params)
        music.save!
        render json: music, status: :created
      rescue StandardError
        head(:unprocessable_entity)
      end

      def update
        music = Music.find(params[:id])
        music.update!(music_params)
        render json: music, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :bad_request
      end

      def delete
        music = Music.find(params[:id])
        music.destroy!
        render json: music, status: :ok
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
