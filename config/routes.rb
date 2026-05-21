Rails.application.routes.draw do
  resources :chapters

  root "home_page#index"
   get "/search", to: "search#index", as: :search

  get "/creators/new", to: "creators#new", as: :new_creator
  get "/creators/:uuid", to: "creators#show", as: :creator
  get "/creators/:uuid/about", to: "creators#about", as: :about_creator
  get "/creators/:uuid/edit", to: "creators#edit", as: :edit_creator
  post "/creators", to: "creators#create"
  patch "/creators/:id", to: "creators#update"
  delete "/creators/:id", to: "creators#destroy", as: :delete_creator

  get "/writings/new", to: "writings#new", as: :new_writing
  get "/writings/:uuid/edit", to: "writings#edit", as: :edit_writing
  patch "/writings/:uuid", to: "writings#update", as: :update_writing
  get "/writings", to: "writings#index", as: :writings
  post "/writings", to: "writings#create"

  namespace :settings do
    resource :password, only: [ :show, :update ]
    resource :email, only: [ :show, :update ]
    get "/profile_page", to: "profile_page#show", as: :profile_page
    patch "/profile_page/username", to: "profile_page#update_username"
    get "/creator/:uuid", to: "creator#show", as: :creator

    root to: redirect("/settings/profile_page")
  end


  get "/about_page", to: "about_page#index"
  get "/donate_page", to: "donate_page#index"


  resource :session
  resources :passwords, param: :token
  resource :sign_up
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
