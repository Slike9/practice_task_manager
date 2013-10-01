class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Personalization

  helper_method :user_signed_in?, :current_user

  add_breadcrumb :home, :root_path
end
