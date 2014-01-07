module SitesHelper

def index
    Twitter.configure do |config|
	    config.consumer_key = 'C0PCtX0ro4wLKQyIhxkw'
	    config.consumer_secret = 'kHzF3UmXHMcEZV4B7K2LEB5jTyjw9XimwoiFMKl9c'
	    config.oauth_token = '1364699594-8WLNvPFBgpW2bw2jRWWB5hztJw4qzbWPOm4Tult'
	    config.oauth_token_secret = 'nMxW06tWdhDsKY3Kan3jLE7zEm7yMcOWAgn839CKd2k'

	    @tweets = Twitter.search("finance stock $", :lang => "en", :count => 5, :result_type => "recent").results
	  end
	end

	def show
    @q = params[:q]

    quote_type = YahooFinance::StandardQuote
    quote_symbol = @q
    @ticker_info = []
    YahooFinance::get_quotes( quote_type, quote_symbol ) do |qt|
      @ticker_info << qt.symbol
      @ticker_info << qt.name
      @ticker_info << qt.open.round(2)
      @ticker_info << qt.dayHigh.round(2)
      @ticker_info << qt.dayLow.round(2)
      @ticker_info << qt.changePercent
      @ticker_info << qt.date
    end
    if @ticker_info[2] == 0.0
      puts "This is not a valid stock ticker. Please search again."
    else
      Twitter.configure do |config|
  	    config.consumer_key = 'C0PCtX0ro4wLKQyIhxkw'
  	    config.consumer_secret = 'kHzF3UmXHMcEZV4B7K2LEB5jTyjw9XimwoiFMKl9c'
  	    config.oauth_token = '1364699594-8WLNvPFBgpW2bw2jRWWB5hztJw4qzbWPOm4Tult'
  	    config.oauth_token_secret = 'nMxW06tWdhDsKY3Kan3jLE7zEm7yMcOWAgn839CKd2k'

  	    @tweets = Twitter.search(@q, :lang => "en", :count => 5, :result_type => "recent").results
  			@sentiment = []

    		@tweets.each do |tweet|
    			@text = tweet.text
    			request = Typhoeus.get("https://api.sentigem.com/external/get-sentiment?api-key=beb264c6ed3b2ceceb3fec2b8935f0d8WeqESx3iDdLFpcQ-4T5IOKHP_o7zj0VB&", params: {text: @text})
  				@sentiment << JSON.parse(request.body)["polarity"]
    		end

    		if @q.length > 4
  	      flash[:errors] = "Not a 4 character symbol."
  	      redirect_to "/"
    		end
  		end
    end
	end

end
