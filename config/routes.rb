Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  get 'signup', to: 'users#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  root 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
