Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :musicians
  resources :genres 
  resources :relationships
  resources :musician_genres
  resources :comments, only: [:create]

  get '/login', to: 'sessions#new'
  # get '/sign_in', to: 'sessions#sign_in'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  get 'musicians/:id/follow', to: "musicians#follow", as: 'follow_musician'
  get 'musicians/:id/unfollow', to: "musicians#unfollow", as: 'unfollow_musician'
  get '/analytics', to: "musicians#analytics", as: 'analytics'
  post '/analytics', to: "musicians#spec_analytics", as: 'spec_analytics'
  

  post 'comments/:id/like', to: "comments#like", as: 'like_comment'

end
