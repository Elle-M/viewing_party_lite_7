Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "welcome#index"

  get "/register", controller: "users", to: "users#new"

	resources :users, only: [:create, :show] do
		resources :discover, only: :index
    resources :movies, only: [:index, :show] do
			resources :parties, only: [:show, :new, :create]
		end
	end
	
end