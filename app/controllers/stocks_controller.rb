require 'yahoofinance'

class StocksController < ApplicationController

		def index
			@stocks = Stock.all
			@user = User.find(current_user.id)
			@stocker = @user.stocks
			@sentiments = []
			@stocker.each do |symbol|
				@symbol = symbol.tickersymbol
		    Twitter.configure do |config|
			    config.consumer_key = 'C0PCtX0ro4wLKQyIhxkw'
			    config.consumer_secret = 'kHzF3UmXHMcEZV4B7K2LEB5jTyjw9XimwoiFMKl9c'
			    config.oauth_token = '1364699594-8WLNvPFBgpW2bw2jRWWB5hztJw4qzbWPOm4Tult'
			    config.oauth_token_secret = 'nMxW06tWdhDsKY3Kan3jLE7zEm7yMcOWAgn839CKd2k'
			    @tweets = Twitter.search(@symbol, :lang => "en", :count => 10, :result_type => "recent").results
		  		@sentiment = []
		  		@tweets.each do |tweet|
		  			@text = tweet.text
		  			request = Typhoeus.get("https://api.sentigem.com/external/get-sentiment?api-key=beb264c6ed3b2ceceb3fec2b8935f0d8WeqESx3iDdLFpcQ-4T5IOKHP_o7zj0VB&", params: {text: @text})
						@sentiment << JSON.parse(request.body)["polarity"]
		  		end
		  		@sentiments << @sentiment
				end
			end
		end

		def new
			@stock = Stock.new
		end

		def create
			user_id = @current_user.id
			new_stock = Stock.create(params[:stock])
			redirect_to stock_path(new_stock.id)
		end

		def show
			# THIS METHOD IS FOR WHEN THE USER SEARCHES FOR A TICKER
			@stock = Stock.find(params[:blah])
		end

		def edit
			@stock = Stock.find(params[:blah])
		end

		def update
			found_stock = Stock.find(params[:blah])
			found_stock.update_attributes(params[:stock])
			redirect_to stock_path(found_stock)
		end

		def destroy
			Stock.delete(params[:blah])
			redirect_to stocks_path
		end

end
