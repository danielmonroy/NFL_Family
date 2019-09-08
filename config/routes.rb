Rails.application.routes.draw do
  resources :forecasts
  resources :pools
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :demo
  resources :teams
  resources :games
  resources :contenders

  root "pools#index"
end
