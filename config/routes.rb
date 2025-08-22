Rails.application.routes.draw do

  get "/demon_slayers", to: "demon_slayers#index", as: 'demon_slayers'
  get '/demon_slayers', to: "demon_slayers#export", as: 'export_demon_slayers'
  post "/demon_slayers", to: "demon_slayers#create"
  get "/demon_slayers/new", to: "demon_slayers#new", as: 'new_demon_slayer'
  get "/demon_slayers/:id/edit", to: "demon_slayers#edit", as: 'edit_demon_slayer'
  get "/demon_slayers/:id", to: "demon_slayers#show", as: 'demon_slayer'
  patch "/demon_slayers/:id", to: "demon_slayers#update"
  put "/demon_slayers/:id", to: "demon_slayers#update"
  delete "/demon_slayers/:id", to: "demon_slayers#destroy"


  # resources :demon_slayers
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
