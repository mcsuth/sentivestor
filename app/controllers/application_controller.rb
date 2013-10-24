class ApplicationController < ActionController::Base

  protect_from_forgery
  include SessionsHelper
  include SitesHelper
  before_filter :authenticate

end