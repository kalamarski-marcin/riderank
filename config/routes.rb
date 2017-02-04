Rails.application.routes.draw do
  root to: 'taxi_rides#index'

  resources :taxi_rides, only: [:index, :create, :destroy]
end
