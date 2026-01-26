Rails.application.routes.draw do

  devise_for :users, skip: [:registrations], controllers: { sessions: "users/sessions" }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "/demo-login",  to: "demo_sessions#create",  as: :demo_login
  delete "/demo-logout", to: "demo_sessions#destroy", as: :demo_logout

  # Administration des utilisateurs
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end

  # Dashboard
  resource :dashboard, only: [:show]

  # Profil utilisateur
  resource :profile, only: [:show, :edit, :update, :destroy]

  # Catégories
  resources :categories

  # Fournitures
  resources :fournitures do
    collection do
      get :stock_bas
    end
  end

  # Liste d'achat
  resource :liste_achat, only: [:show] do
    resources :items, only: [:create, :edit, :update, :destroy], module: :liste_achat
  end

  # Liens footer
  get  "/contact", to: "contacts#new", as: "contact"
  post "/contact", to: "contacts#create"
  get "/mentions-legales", to: "pages#mentions_legales"
  get "/confidentialite", to: "pages#confidentialite"

  authenticate :user, ->(u) { u.admin? } do
    mount RailsAdmin::Engine => "/rails_admin", as: "rails_admin"
  end
end
