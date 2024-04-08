class ApplicationController < ActionController::Base
  include Pagy::Backend

  class NotAuthorizedError < StandardError; end

  rescue_from NotAuthorizedError do
    redirect_to(products_path, alert: 'Not authorized')
  end

  before_action :set_current_user
  before_action :protect_pages

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to(new_session_path, alert: 'Not logged in') unless Current.user
  end

  def authorize!(item = nil)
    if item
      is_allowed = item.user_id == Current.user.id
      # redirect_to(products_path, alert: 'Not authorized') unless is_allowed # Esto arrojaba error porque aca se redirecciona y hay metodos q tambien redireccionan
    else
      is_allowed = Current.user.admin?
    end
    raise NotAuthorizedError unless is_allowed # El raise corta todo flujo adicional como el redirect de los otros metodos
  end
end
