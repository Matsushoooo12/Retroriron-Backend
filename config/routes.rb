Rails.application.routes.draw do
  root 'top#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :news, only: %i[index]
      resources :lives, only: %i[index]
      resources :discographies, only: %i[index]
      resources :contacts, only: %i[create]
      resources :tickets, only: %i[create]
    end
  end
end
