Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        resources :users, only: [:index, :create, :update, :show]
        resources :genders, only: [:index, :show]
        post '/login', to: 'auth#create'
        get '/profile', to: 'users#profile'
      end
    end
end
