class Api::V1::MusicsController < ApplicationController
    def index
      musics = Music.all
      render json: musics, status: :ok
    end

    def show
       music = Music.find(params[:id])
       render json music, status: :ok
    rescue StandardError
        head(:not_found) 
    end

    def create
        music = Music.new(music_params)
        game.save!
        render json: music, status: :created
    rescue StandardError
        head(:unprocessable_entity) 
    end

    private
    def music_params
        params.require(:music).permit(
            :title,
            :description,
            :photo
        )
    end
    
    def update
        music = Music.find(params[:id])
        music.update!(music_params)
        render json: music, status: :created
    rescue StandardError
        head(:unprocessable_entity) 
    end

    def delete
        music = Music.find(params[:id])
        music.destroy!
        render json: game, status: :ok
end
