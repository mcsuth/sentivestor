# Current Confidence Web Application
<hr>
I wanted to create an application that will allow you to search for #ABC and get the sentiment value of the tweets that mention #ABC.

* Current Confidence is currently in its BETA stage. More features to be added in the future.

***HOW TO USE IT***

	1. Log-in or create new account
	2. Search item (right now only 5 character items are searchable)
	3. View sentiment graph & retreived tweets
	4. Create a portfolio of saved searches (no restriction on character letters)

***PROGRESSION OF PROJECT***

	1. [Page #1] User goes to website and searches for stock ticker. I.E. AAPL

	2. [API/Gem #1: Tweet Scraper] Application will look up any hashtags on twitter that contain the searched stock ticker
		* GEM: http://sferik.github.io/twitter/
		* API: https://dev.twitter.com/docs/api/1.1/get/search/tweets <<<
		* API: http://rdoc.info/gems/twitter#Quick_Start_Guide

	3. [API #2: Sentiment Analysis] Application will analyze the tweet/string and assign the tweet as either high, medium, low sentiment/confidence
		* LITERATURE: http://www.umiacs.umd.edu/~saif/WebPages/Abstracts/NRC-SentimentAnalysis.htm
		* API: https://developers.google.com/prediction/docs/hello_world
		* API: SentiGem

	4. [Page #2] Application will yield results from API #2 and display it out on the final page.

	5. [Model #1] User Log-in/Authentication

	6. [Model #2] Allow users to create portfolio of saved items/companies

	7. [Gem #2] Graphical Representation of Sentiments
		* http://ankane.github.io/chartkick/

	X. [Javascript] Autocompletion
		* ftp://ftp.nasdaqtrader.com/SymbolDirectory/nasdaqlisted.txt
		* http://autoc.finance.yahoo.com/autoc?query=google&callback=YAHOO.Finance.SymbolSuggest.ssCallback




***RECOMMENDATIONS***

	1. Smaller methods
	2. OK -- Delete test code in Stocks Controller (ex: puts $$$$$$$$$$$$$$$)
	3. Rename params (ex: "blah")
	4. Move API calls from controller to model
	5. OK -- Add flash errors




<!--***RAILS***
	1. rails new current_confidence
	2. cd current_confidence $ subl .
	3. Gemfile: add the below gems @ the top of the file and then in the terminal: bundle install
		gem 'typhoeus'
		gem "twitter"
	4. rename index.html
	5. rails g controller sites
	6. routes.rb
		root to: "sites#index"
	7. sites_controller.rb
		def index
			# render inline: "Testing the render"
		end
	8. touch app/views/sites/index.html.erb
		<h1>Search For Stock Ticker</h1>
		<form method="post" action="/sites">
			<input type="text" placeholder="Type in Ticker">
			<input type="submit">
		</form>
	9. sites_controller.rb
		def index
		 #I can keep this empty
		end
	10. routes.rb
		post "/sites", to: "sites#search"
	11. sites_controller.rb
		def show
			@q = params[:q]
			Twitter.configure do |config|
			  config.consumer_key = 'C0PCtX0ro4wLKQyIhxkw'
			  config.consumer_secret = 'kHzF3UmXHMcEZV4B7K2LEB5jTyjw9XimwoiFMKl9c'
			  config.oauth_token = '1364699594-8WLNvPFBgpW2bw2jRWWB5hztJw4qzbWPOm4Tult'
			  config.oauth_token_secret = 'nMxW06tWdhDsKY3Kan3jLE7zEm7yMcOWAgn839CKd2k'
				@test1 = Twitter.search(@q, :lang => "en", :count => 3, :result_type => "recent").results
			end
		end
	12. touch app/views/sites/show.html.erb
	You searched for: <br><%= @q %><br><br>
	<% @test1.each do |tweet| %>
		<%= tweet.text %><br>
		<%= tweet.created_at %><br><br>
	<% end %>
	13. rails g model tweetter text:string created:datetime location:string
	…
	14. create user model for user authentication
	…
	15. rails g controller stocks
	16. rails g model stock & update migrate files to add schemas
		* t.string :tickersymbol
    	* t.string :company
    	* t.integer :user_id
		* This model should allow the users to save their favorite stock symbols and a description of the symbols/comany. A foreign key is needed to pair many symbols to one user (1 to many relationship).
	17. app/models/stock.rb >>> attr_accessible :tickersymbol, :company
	18. rake db:migrate
	19. edit routes

		get "/symbols", to: "symbols#index"

		#for getting a form to create a new ssymbol
		get "/symbols/new", to: "symbols#new", as: "new_ssymbol"
		# get "/hello/world/today", to: "symbols#index", as: "hello"

		get "/symbols/:blah", to: "symbols#show", as: "ssymbol"
		# get request for the edit form

		post "/symbols", to: "symbols#create"

		get "/symbols/:blah/edit", to: "symbols#edit", as:"edit_ssymbol"

		put "/symbols/:blah", to: "symbols#update"

		delete "/symbols/:blah", to: "symbols#destroy"
	20. touch app/views/stocks/index.html.erb
	21. edit symbols_controller
		def index
			@symbols = Ssymbol.all
			# render :index
		end

		def new
			@ssymbol = Ssymbol.new
		end

		def create
			# raise params
			# raise params[:ssymbol]
			new_ssymbol = Ssymbol.create(params[:ssymbol])
			redirect_to ssymbol_path(new_ssymbol.id)
			# redirect_to "/symbols/#{new_ssymbol.id}"
		end

		def show
			@ssymbol = Ssymbol.find(params[:blah])
		end

		def edit
			@ssymbol = Ssymbol.find(params[:blah])
		end

		def update
			found_ssymbol = Ssymbol.find(params[:blah])
			found_ssymbol.update_attributes(params[:ssymbol])
			redirect_to ssymbol_path(found_ssymbol)
		end

		def destroy
			# ssymbol.find(params[:blah]).destroy
			Ssymbol.delete(params[:blah])
			redirect_to symbols_path
		end
	22. edit /app/views/stocks/index.html.erb
		<%= link_to "Add Symbol", new_ssymbol_path %>
		<br>
		<% @symbols.each do |symb| %>
			<%= render "ssymbol", ssymbol: symb%>
		<% end %>
	23. touch app/views/stocks/new.html.erb
	24. touch app/views/stocks/_form.html.erb
	25 ...
-->