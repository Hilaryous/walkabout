Rails.application.routes.draw do
  root "static_pages#home"
  resources :sights
  resources :walks

  match 'auth/:provider/callback', to: 'sessions#create', via: "get"
  match 'auth/failure', to: redirect('/'),   via: "get"
  match 'signout', to: 'sessions#destroy', via: "get"
end
