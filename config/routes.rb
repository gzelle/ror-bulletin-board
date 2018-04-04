Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
	root 'topics#index'
	get 'home/index'
	get '/users/manageuser/:id', to: 'users#manageuser', as: 'manage_user'
	get '/boardthreads/managethread/:id', to: 'boardthreads#managethread', as: 'manage_thread'

	resources :posts
	resources :users
	

	resources :topics do
	  resources :boards
	end
	resources :topics

	resources :boards do
	  resources :boardthreads
	end
	resources :boards

	resources :boardthreads do
	  resources :posts
	end
	resources :boardthreads

	resources :boardthreads do
	  member do
	    get 'set_boardthread'
	  end
	end

	resources :boards do
	  post :update_row_order, on: :collection
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
