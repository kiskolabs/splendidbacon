class Magic::UsersController < Magic::BaseController
  def index
    @users = User.real.order("email ASC").paginate :page => params[:page], :per_page => 50
  end
  
  def show
    @user = User.find(params[:id])
  end
end
