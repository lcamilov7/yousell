class Authentication::SessionsController < ApplicationController
  skip_before_action :protect_pages

  def new; end

  def create
    @user = User.find_by("email = :login OR username = :login", { login: params[:login] })
    # el método authenticate permite comprobar la contraseña pasada por formulario con la guardada en base de datos
    if @user&.authenticate(params[:password]) # Solamente se invoca el metodo authenticate si el usuario existe (&)
      session[:user_id] = @user.id
      redirect_to(products_path, notice: 'Logged In')
    else
      redirect_to(new_session_path, alert: 'Wrong credentials')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to(products_path, notice: 'Logged out')
  end
end
