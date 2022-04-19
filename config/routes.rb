# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :all
  resources :musics do
    resources :ratings
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'users' do
        post '/login', to: 'users#login'
        get '/logout', to: 'users#logout'
        get '/index', to: 'users#index'
        get '/show', to: 'users#show'
        post '/create', to: 'users#create'
        patch '/update/:id', to: 'users#update'
        delete '/delete/:id', to: 'users#delete'
      end

      scope 'ratings' do
        get 'index', to: 'ratings#index'
        get 'show/:id', to: 'ratings#show'
        post 'create', to: 'ratings#create'
        put 'update/:id', to: 'ratings#update'
        delete 'delete/:id', to: 'ratings#delete'
      end

      scope 'musics' do
        get 'index', to: 'musics#index', as: :music_index
        get 'show/:id', to: 'musics#show', as: :music_show
        post 'create', to: 'musics#create', as: :music_post
        put 'update/:id', to: 'musics#update', as: :music_put
        delete 'delete/:id', to: 'musics#delete', as: :music_delete
      end
    end
  end
end
