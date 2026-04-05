Rails.application.routes.draw do
  resources :creators
  

  namespace :settings do
    resource :password, only: [:show, :update]
    resource :email, only: [ :show, :update]
    get "/profile_page", to: "profile_page#show", as: :profile_page
    patch "/profile_page/username", to: "profile_page#update_username"
    get "/creator/:uuid", to: "creator#show", as: :creator

    root to: redirect("/settings/profile_page")
  end

  root "home_page#index"
  get "home_page/index"
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
