class ApplicationController < ActionController::Base
  include Authentication
  include Authorization # Aqui esta toda la logica que tiene que ver con autorizacion, da lo mismo ponerla aca o en el modulo solo ques para que no quede este archivo tan largo y mejor mas ordenado
  include Pagy::Backend

  before_action :set_current_user # Estos dos metodos callback estan definidos en el modulo Authetication
  before_action :protect_pages
end
