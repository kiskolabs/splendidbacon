class Magic::UsersController < Magic::BaseController
  def index
    title "Users"
    @users = User.real.order("email ASC").paginate :page => params[:page], :per_page => 50
  end
  
  def show
    @user = User.find(params[:id])
    title "User: #{@user.name}"
  end
end
