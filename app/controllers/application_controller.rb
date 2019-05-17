class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # TODO: implement authentication
  # before_action :authenticate_user!
end
