Rails.application.routes.draw do
	root 'topics#index'
	get 'home/index'
	post '/users/banuser', to: 'users#banuser'
	post '/users/unbanuser', to: 'users#unbanuser'

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
