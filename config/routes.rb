CurrentConfidence::Application.routes.draw do

  root to: "sites#index"
  post "/sites", to: "sites#show"

  resources :users, except: [:index]
  resources :sessions, only: [:new, :create]

  get "/logout", to: "sessions#destroy"



		get "/stocks", to: "stocks#index"

		#for getting a form to create a new stock
		get "/stocks/new", to: "stocks#new", as: "new_stock"
		# get "/hello/world/today", to: "stocks#index", as: "hello"

		get "/stocks/:blah", to: "stocks#show", as: "stock"
		# get request for the edit form

		post "/stocks", to: "stocks#create"

		get "/stocks/:blah/edit", to: "stocks#edit", as:"edit_stock"

		put "/stocks/:blah", to: "stocks#update"

		delete "/stocks/:blah", to: "stocks#destroy"


end
