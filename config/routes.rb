Rails.application.routes.draw do
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



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
