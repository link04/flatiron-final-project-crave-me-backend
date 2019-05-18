Rails.application.routes.draw do
  namespace :api do
      namespace :v1 do
        resources :users, only: [:index, :create, :update, :show]
        resources :genders, only: [:index]
        resources :menu_choices, only: [:index]
        resources :craves, only: [:create]
        resources :matched_craves, only: [:update]

        post '/login', to: 'auth#create'
        get '/profile', to: 'users#profile'
        patch '/update_coordinates/:id', to: 'users#update_coordinates'
        get '/show_matches/:id', to: 'users#show_matches'

        resources :messages, only: [:create]
        resources :conversations, only: [:show, :destroy]
        mount ActionCable.server => '/cable'

      end
    end
end
