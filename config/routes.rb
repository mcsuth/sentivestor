CurrentConfidence::Application.routes.draw do

  root to: "sites#index"

  post "/sites", to: "sites#show"

  resources :users, except: [:index]

  resources :sessions, only: [:new, :create]

  get "/logout", to: "sessions#destroy"

	get "/stocks", to: "stocks#index"

	get "/stocks/new", to: "stocks#new", as: "new_stock"

	get "/stocks/:blah", to: "stocks#show", as: "stock"

	post "/stocks", to: "stocks#create"

	get "/stocks/:blah/edit", to: "stocks#edit", as:"edit_stock"

	put "/stocks/:blah", to: "stocks#update"

	delete "/stocks/:blah", to: "stocks#destroy"

end
