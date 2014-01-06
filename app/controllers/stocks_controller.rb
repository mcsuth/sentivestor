require 'pry'
class StocksController < ApplicationController

	def index
		@stocks = Stock.all
		@user = User.find(current_user.id)
		@stocker = @user.stocks
		@sentiments = []
		@ticker_info = []
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

		    quote_type = YahooFinance::StandardQuote
		    quote_symbol = @symbol
		    each_item = []
		    YahooFinance::get_quotes(quote_type, quote_symbol) do |qt|
		      each_item << qt.name
		      each_item << qt.open
		      each_item << qt.dayHigh
		      each_item << qt.dayLow
		      each_item << qt.changePercent
		      each_item << qt.date
		    end
				puts each_item
				@ticker_info << each_item
				puts "=============="
			end
		end
	end

	def new
		@stock = Stock.new
	end

	def create
		user_id = @current_user.id
		new_stock = Stock.new(params[:stock])

		ticker = new_stock.tickersymbol
		quote_type = YahooFinance::StandardQuote
	  @ticker_info = []
	  YahooFinance::get_quotes( quote_type, ticker ) do |qt|
	    @ticker_info << qt.open
	  end
	  if @ticker_info != [0.0]
	  	new_stock = Stock.create(params[:stock])
			redirect_to stock_path(new_stock.id)
	  else
	  	flash[:errors] = "Not a valid stock ticker. Please try again."
	  	redirect_to "/stocks"
	  end

	end

	def show
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
