class Magic::UsersController < Magic::BaseController
  def index
    title "Users"
    @users = User.real.order("email ASC").page(params[:page]).per(50)
  end
  
  def show
    @user = User.find(params[:id])
    title "User: #{@user.name}"
  end
end
