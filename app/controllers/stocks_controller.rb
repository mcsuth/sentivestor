class StocksController < ApplicationController

		def index

			@stocks = Stock.all
			# @stock = Stock.find(current_user.name)
			@user = User.find(current_user.id)
			# render :index
			@stocker = @user.stocks
				@stocker.each do |symbol|
					# puts "$"
					@symbol = symbol.tickersymbol




					    Twitter.configure do |config|
						    config.consumer_key = 'C0PCtX0ro4wLKQyIhxkw'
						    config.consumer_secret = 'kHzF3UmXHMcEZV4B7K2LEB5jTyjw9XimwoiFMKl9c'
						    config.oauth_token = '1364699594-8WLNvPFBgpW2bw2jRWWB5hztJw4qzbWPOm4Tult'
						    config.oauth_token_secret = 'nMxW06tWdhDsKY3Kan3jLE7zEm7yMcOWAgn839CKd2k'

						    @tweets = Twitter.search(@symbol, :lang => "en", :count => 5, :result_type => "recent").results


								@sentiment = []


							  		@tweets.each do |tweet|
							  			@text = tweet.text


							  			request = Typhoeus.get("https://api.sentigem.com/external/get-sentiment?api-key=beb264c6ed3b2ceceb3fec2b8935f0d8WeqESx3iDdLFpcQ-4T5IOKHP_o7zj0VB&", params: {text: @text})
											@sentiment << JSON.parse(request.body)["polarity"]

							  		end

												puts "$$$$$$$$$$$$$$$$$$$$$$$$"
											  puts @sentiment

					  		@sentimentneg = (@sentiment.count("negative").to_f/(@sentiment.count("positive").to_f+@sentiment.count("negative").to_f+@sentiment.count("neutral").to_f)*100)
					  		@sentimentpos = (@sentiment.count("positive").to_f/(@sentiment.count("positive").to_f+@sentiment.count("negative").to_f+@sentiment.count("neutral").to_f)*100)
					  		@sentimentneu = (@sentiment.count("neutral").to_f/(@sentiment.count("positive").to_f+@sentiment.count("negative").to_f+@sentiment.count("neutral").to_f)*100)

					  			stockticker = @symbol.upcase
									@quotes = YahooFinance::get_standard_quotes(stockticker)
									@price = @quotes[stockticker].lastTrade
									@name = @quotes[stockticker].name
									@date = @quotes[stockticker].date

							end
				end
		end

		def new
			@stock = Stock.new
		end

		def create
			user_id = @current_user.id
			# raise params
			# new_stock = Stock.create(tickersymbol: params[:tickersymbol], company: params[:company], user_id: user_id)
			new_stock = Stock.create(params[:stock])
			redirect_to stock_path(new_stock.id)
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
			# stock.find(params[:blah]).destroy
			Stock.delete(params[:blah])
			redirect_to stocks_path
		end

end
