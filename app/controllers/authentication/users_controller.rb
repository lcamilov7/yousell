class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Aqui debemos darle el valor a country ANTES del save porque si va despues habria que darle update (LUEGO CON BACKGROUND JOB SI SERA UPDATE)
    # @user.country = FetchCountryService.new(request.remote_ip).perform # Esta linea se encarga de darle country code al user mediante el service Fetch... en services/fetch_country_service.rb
    # request.remote_ip extrae la ip desde donde se está haciendo la peticion, no funciona en localhost

    if @user.save
      FetchCountryJob.perform_later(@user.id, request.remote_ip) # Esta lina hara un background job asincrono para darle country al usuario recien creado porque no podemos esperar a que la api responda para seguir con el flujo de codigo, esto lo soluciona background job de manera asincrona, hay que decirl perform_later para que lo haga asincrono y le pasamos el id del usuario y la ip
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
