Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  #resources :homes, only: [:index]
  resources :books
  resources :users, only: [:index, :show, :edit, :update]

end
