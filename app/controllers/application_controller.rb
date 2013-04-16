class ApplicationController < ActionController::Base
  #include PublicActivity::StoreController
  rescue_from(Exception) { # Or just handle particular exceptions
    # do stuff
    redirect_to home_path
  }

  include Engage::Extensions::Helpers
    protect_from_forgery
    rescue_from CanCan::AccessDenied do |exception|
  	  flash[:error] = "Access denied."
  	  redirect_to home_url
    end


end
