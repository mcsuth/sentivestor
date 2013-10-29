require 'spec_helper'

describe Stock do
	let(:stock) {Stock.create(tickersymbol: "GOOG", company: "Google", user_id:1)}

	it "should have a id" do
	   stock.should respond_to(:id)
	   stock.id.should_not == nil
	end

	it "should have a company tickersymbol" do
	   stock.should respond_to(:tickersymbol)
	   stock.tickersymbol.should_not == nil
	end

	it "should have a company description" do
	   stock.should respond_to(:company)
	   stock.company.should_not == nil
	end

	it "should be assigned to some user" do
	   stock.should respond_to(:user_id)
	   stock.user_id.should_not == nil
	end

	it "should not take tickersymbols that are more than 4 characters" do
		long_tickersymbol = Stock.create(tickersymbol: "GOOGLE", company: "Google", user_id:1)
		stock.long_tickersymbol.length.should_not > 4
	end

end
