class CategoryPolicy < BasePolicy
  def method_missing(m, *args, &block) # nos ahorra tener q escribir los 7 metodos y sobreescibe el mismo metodo con el mismo nombre de clase padre BasePolicy
    Current.user.admin?
  end

  # def index
  #   Current.user.admin?
  # end

  # def new
  #   Current.user.admin?
  # end

  # def create
  #   Current.user.admin?
  # end

  # def edit
  #   Current.user.admin?
  # end

  # def update
  #   Current.user.admin?
  # end

  # def destroy
  #   Current.user.admin?
  # end
end
