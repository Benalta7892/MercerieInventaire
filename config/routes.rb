Rails.application.routes.draw do
  get 'fournitures/index'
  get 'fournitures/show'
  get 'fournitures/new'
  get 'fournitures/create'
  get 'fournitures/edit'
  get 'fournitures/update'
  get 'fournitures/destroy'
  get 'fournitures/stock_bas'
  get 'categories/index'
  get 'categories/show'
  get 'categories/new'
  get 'categories/create'
  get 'categories/edit'
  get 'categories/update'
  get 'categories/destroy'
  get 'dashboards/show'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #
  # Dashboard
  resource :dashboard, only: [:show]

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
    resources :items, only: [:create, :destroy], module: :liste_achat
  end
end
