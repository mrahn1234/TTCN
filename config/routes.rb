Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	root 'static_pages#index'
	devise_for :users
	resources :books
	resources :authors
	post '/sort', to: "books#sort"
	get '/get_rq_json', to: "requests#get_rq_json"
	# post '/confirm', to: "carts#confirm"
	# get '/get_request_params', to: "carts#get_request_params"
	get "/my_cart/:id", to: "carts#my_cart"
	resources :carts do
		member do
			# get "confirm"
			post "confirm"
			get "accept"
			get "decline"
			get "detail"
		end
	end
	resources :requests 
	get '/crud_book', to: "books#crud_book"

end
