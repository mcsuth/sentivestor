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
    Twitter.configure do |config|
	    config.consumer_key = 'C0PCtX0ro4wLKQyIhxkw'
	    config.consumer_secret = 'kHzF3UmXHMcEZV4B7K2LEB5jTyjw9XimwoiFMKl9c'
	    config.oauth_token = '1364699594-8WLNvPFBgpW2bw2jRWWB5hztJw4qzbWPOm4Tult'
	    config.oauth_token_secret = 'nMxW06tWdhDsKY3Kan3jLE7zEm7yMcOWAgn839CKd2k'

	    @tweets = Twitter.search(@q, :lang => "en", :count => 15, :result_type => "recent").results
			@sentiment = []
			@charater = []

  		@tweets.each do |tweet|
  			@text = tweet.text
  			request = Typhoeus.get("https://api.sentigem.com/external/get-sentiment?api-key=beb264c6ed3b2ceceb3fec2b8935f0d8WeqESx3iDdLFpcQ-4T5IOKHP_o7zj0VB&", params: {text: @text})
				@sentiment << JSON.parse(request.body)["polarity"]
				@charater << JSON.parse(request.body)["char_count"]
  		end

  		if @q.length > 5
  			redirect_to "/"
  		end
  		@sentimentneg = (@sentiment.count("negative").to_f/(@sentiment.count("positive").to_f+@sentiment.count("negative").to_f+@sentiment.count("neutral").to_f)*100)
  		@sentimentpos = (@sentiment.count("positive").to_f/(@sentiment.count("positive").to_f+@sentiment.count("negative").to_f+@sentiment.count("neutral").to_f)*100)
  		@sentimentneu = (@sentiment.count("neutral").to_f/(@sentiment.count("positive").to_f+@sentiment.count("negative").to_f+@sentiment.count("neutral").to_f)*100)
  		@chart = ("http://chart.finance.yahoo.com/z?s=@q&t=6m&q=l")

		end
	end

end
