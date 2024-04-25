class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.country = FetchCountryService.new('24.48.0.1').perform

    if @user.save
      # El with(user: @user) envia un params[:user] = @user al mailer
      UserMailer.with(user: @user).welcome.deliver_later # Queremos enviar un email de bienvenida al que se registre, deliver_later es para que lo haga sincrono y no haya que esperar que se envie el email para seguir a la siguiente linea de codigo
      session[:user_id] = @user.id
      redirect_to(products_path, notice: 'User created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
