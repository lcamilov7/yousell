class ApplicationController < ActionController::Base
  include Authentication # Aca estan los metodos de autenticación set_current_user y protect_pages
  include Authorization # Aqui esta toda la logica que tiene que ver con autorizacion, da lo mismo ponerla aca o en el modulo solo ques para que no quede este archivo tan largo y mejor mas ordenado
  include Pagy::Backend # hacemos paginación con pagy
  include Errors # Aqui pondremos los errores
  # Debemos poner los include en orden, primero nos autenticamos, luego segun eso tendremos o no autorizaciones, luego

  before_action :set_current_user # Estos dos metodos callback estan definidos en el modulo Authetication
  before_action :protect_pages
end
