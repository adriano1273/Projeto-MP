Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'ratings' do
        get 'index', to: 'ratings#index'
        get 'show/:id', to: 'ratings#show'
        post 'create', to: 'ratings#create'
        put 'update/:id', to: 'ratings#update'
        delete 'delete/:id', to: 'ratings#delete'
      end
    end
  end
end
