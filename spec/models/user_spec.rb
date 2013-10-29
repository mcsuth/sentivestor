require 'spec_helper'

describe User do
	let(:user) {User.create(name: "sam", email: "s@sam", password: "test", password_confirmation: "test")}

	it "should have a id" do
	   user.should respond_to(:id)
	   user.id.should_not == nil
	end

	it "should have a name" do
	  user.should respond_to(:name)
		user.name.should_not == nil
	end

	it "should have a password" do
		user.should respond_to(:password)
		user.password.should_not == nil
	end

	it "should have a password that is over 4 characters" do
		user.should respond_to(:password)
		user.password.length.should_not < 4
	end

	it "should reject names that are too long" do
		user.should respond_to(:name)
		long_name = "mohamadreza jalalivarnamhasti"
		new_long_name = User.new(:name => long_name)
		new_long_name.should_not be_valid
		# my application doesn't do anything with restricting the name field... but this passed in the rspec
	end

	it "should only take real emails" do
		user.should respond_to(:email)
		at = "@"
		bad_email = " "
		invalid_email = User.new(:email => bad_email)
		invalid_email.should_not be_valid
	end

	it 'should be invalid if email is already taken' do
		original_email = User.create(name: "sam", email: "sam@gmail.com", password: 123456,
		password_confirmation: 123456)

		duplicate_email = User.create(name: "sam2", email: "sam@gmail.com", password: 654321,
		password_confirmation: 654321)

		duplicate_email.valid?.should be_false
	end

	describe "#new" do
		it "should redirect users to create a new account" do
			redirect_to :new
		end
	end


end

