Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'musics' do
        get 'index', to: "musics#index", as: :music_index
        get 'show/:id', to: "musics#show", as: :music_show
        post 'create', to: "musics#create", as: :music_post
        put 'update/:id', to: "musics#update", as: :music_put
        delete 'delete/:id', to: "musics#delete", as: :music_delete
      end
    end
  end
end
