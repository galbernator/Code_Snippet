class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize_admin
    redirect_to root_path, notice: 'You do not have permission to view that page,' unless user_signed_in_as_admin?
  end

  def user_signed_in_as_admin
    current_user.present? && current_user.admin?
  end

  def authorize
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  def user_signed_in
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  helper_method :current_user
end
