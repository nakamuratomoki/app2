Rails.application.routes.draw do
   devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/about' ,to: 'home#about'
  root :to => 'home#top'
  resources :books, only: [ :create, :index, :show,:edit,:destroy,:update]
  resources :users, only: [:show,:edit,:update,:index]
end
