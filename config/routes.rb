Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "signup", to:"users#new"
  resources :users, only: [:show,:create,:new]
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :items, only:[:new, :show]
  #haveもwantも動作は同じなので，ownershipsコントローラでまとめる
  resources :ownerships, only:[:create, :destroy]
  
end