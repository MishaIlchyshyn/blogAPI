Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
      resources :posts, only: %i[index create show destroy] do
        resources :comments, only: %i[index create]
      end
      resources :comments, only: %i[destroy]
    end
  end
end
