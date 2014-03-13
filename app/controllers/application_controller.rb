class ApplicationController < ActionController::Base
  include Engage::Extensions::Helpers
    protect_from_forgery
    rescue_from CanCan::AccessDenied do |exception|
  	  flash[:error] = "Access denied."
  	  redirect_to home_url
    end
end
