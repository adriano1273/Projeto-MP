Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'musics' do
        get 'index', to 'musics#index'
        get 'show/:id' to 'musics#show'
        post 'create', to 'musics#create'
        put 'update/:id', to 'musics#update'
        delete 'delete/:id', tp 'musics#delete'
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
